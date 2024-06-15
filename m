Return-Path: <linux-iio+bounces-6296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC457909828
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B0F1F21302
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E639134B0;
	Sat, 15 Jun 2024 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHn4Q1V+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3922D627;
	Sat, 15 Jun 2024 12:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718453751; cv=none; b=ejJM2oGoz39ZEPftv0XzO75uZQE8ysYjuRFiwiO09cxAr5xfEuGCZxB7ze29eDqEpfBWJveJgvt+THgbkMC49XJ9fWHxPX1CiRczrm6tntD1Hf//Xely3nvmMRns0GNeUS0iNuaLlM8Nyk9kp90AgZlwCh0GnLNzAWoMPNcX9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718453751; c=relaxed/simple;
	bh=UDsgeRvgBxufXfEomliv5Zr8Lbey2revpTd9++0U110=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMQ5+XgRL+baTssgGCynNa4oV0TOn7AmfmeXRDMC9QcfVcVVKCbUJy0DQq+BRMMxRRiaJNtuMlmC1uISMLgU+AAqSJKFwvosI74kr+UogSD3Y8fRMfOrV3o1mwbevPkDzft0qcQZOMpZXVPkjFmc7Mj7I6mZJHJ+zlsplrq7u6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHn4Q1V+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85422C116B1;
	Sat, 15 Jun 2024 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718453750;
	bh=UDsgeRvgBxufXfEomliv5Zr8Lbey2revpTd9++0U110=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kHn4Q1V+pmz9gB8ekYSDEEZIBMAY5qirorAg/Ad7F9d+iv48r1aTgtez+Ce2ZBv9J
	 1XC/8ZFZrxaY9vnlq3f6MY3xX8cP441Mv1kiJG0dQ0BWjwl3FXMRDLdZHXllkoPPmr
	 373iStFQvkTWgKrnFy4/jJRSyCPBHHmVEosZ4sZQ/Ujf3ytXZtQ9SNuosH1XeKPyHg
	 3KuZXiG7rCuSNWwBQIWUuSexvOvIUS1wIEdsFpRLbJ6JnYQ8Aj9msjP2U6jOaoVRm0
	 KSmkMgiBRsaqYwEyNbZF34FEqPOY96rUgYlc+qWpwnqRg9LjuiozPaYALoj+iT+b+7
	 KiCSV6G4MmaGQ==
Date: Sat, 15 Jun 2024 13:15:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: ad7793: use
 devm_regulator_get_enable_read_voltage
Message-ID: <20240615131542.130938be@jic23-huawei>
In-Reply-To: <20240612-iio-adc-ref-supply-refactor-v2-4-fa622e7354e9@baylibre.com>
References: <20240612-iio-adc-ref-supply-refactor-v2-0-fa622e7354e9@baylibre.com>
	<20240612-iio-adc-ref-supply-refactor-v2-4-fa622e7354e9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 16:03:08 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This makes use of the new devm_regulator_get_enable_read_voltage()
> function to reduce boilerplate code.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied

