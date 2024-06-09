Return-Path: <linux-iio+bounces-6106-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4405E9015D3
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 13:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7734B20AC0
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED95A26ADD;
	Sun,  9 Jun 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsyFl8Hu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9483E47E;
	Sun,  9 Jun 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717931036; cv=none; b=P6aSMWU+qHVyvDv2PtwI3cU9SyHVoggi9FonmRXYyDOfL91R5BTHTE+fqGbOe2msF+x1wotn0b/2LEHItns7g+D4ZMP/Zro+xfn3r7W3FCr99A/Y6oF+stZwhV521J9NL3SXqRyNADdd0Eor5vC8qJnXGXN6unjG39/Yf2rd9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717931036; c=relaxed/simple;
	bh=/gQ4V+QthXnYDKIfhkUCXxBGPmP4SuV90qZ+VPFImC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1SW1wOL9dxMkIY1AuxV3x7stE6yhGdWHWRfh7baCbMdpX3BARkCby36Ilu6eaxKRqtomq1R78lLkxmiRGWO6E3IaKp+KW1rDVig4Svgu070GwlbLKGUkXibxXBDnIDvdhk1kQdSx5D+etOPSaK58W1bbrsq8obyGfCz9WvkaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsyFl8Hu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F555C2BD10;
	Sun,  9 Jun 2024 11:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717931036;
	bh=/gQ4V+QthXnYDKIfhkUCXxBGPmP4SuV90qZ+VPFImC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EsyFl8HujZq7TAVA23h6YA+p61I6oPYxLzCfRaERTJ0Bx0hVhIzgIihOfzhQDJkmz
	 sVLa/tDWRqNwG7xTUB+50H7dFaoVTNKXbBT6JmOM37fHGUTlVOF/8YrzoSLX54eFkE
	 YdqS8fxX9fY4P4LiKc1hMyrLnom8P+pJVywAfH0w2xQcz/R5DRFCdbsbYzgQ534xA8
	 Wa97ZiCbPAjWP8EIPU9kXd3MOGixYMImoXwhE5ptlDAAqcsopLg9NO64EqhEcPrNPF
	 UkNNJ/5FTwD7m/RbIOiK+aYTC0Ebf8ABQUJZ5r+78HB6+x8+HtF4JkGV8T7xSFaR52
	 xh8JUK1DtKyjw==
Date: Sun, 9 Jun 2024 12:03:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dpfrey@gmail.com, himanshujha199640@gmail.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 04/19] iio: chemical: bme680: Fix sensor data read
 operation
Message-ID: <20240609120323.5af232f9@jic23-huawei>
In-Reply-To: <20240606212313.207550-5-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
	<20240606212313.207550-5-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 23:22:56 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> A read operation is happening as follows:
> 
> a) Set sensor to forced mode
> b) Sensor measures values and update data registers and sleeps again
> c) Read data registers
> 
> In the current implementation the read operation happens immediately
> after the sensor is set to forced mode so the sensor does not have
> the time to update properly the registers. This leads to the following
> 2 problems:
> 
> 1) The first ever value which is read by the register is always wrong
> 2) Every read operation, puts the register into forced mode and reads
> the data that were calculated in the previous conversion.
> 
> This behaviour was tested in 2 ways:
> 
> 1) The internal meas_status_0 register was read before and after every
> read operation in order to verify that the data were ready even before
> the register was set to forced mode and also to check that after the
> forced mode was set the new data were not yet ready.
> 
> 2) Physically changing the temperature and measuring the temperature
> 
> This commit adds the waiting time in between the set of the forced mode
> and the read of the data. The function is taken from the Bosch BME68x
> Sensor API [1].
> 
> [1]: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L490
> Fixes: 1b3bd8592780 ("iio: chemical: Add support for Bosch BME680 sensor")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied and marked for stable.

