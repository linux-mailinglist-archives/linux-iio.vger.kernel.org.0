Return-Path: <linux-iio+bounces-26073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1044DC4411E
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 15:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CE63AB2AC
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60062FE06B;
	Sun,  9 Nov 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ate3ywjE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2E2FDC54;
	Sun,  9 Nov 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762700228; cv=none; b=UZdIf1ytBQQJCYrWJ5OievelGIWOkuY1C+hPAFbijGgqtIFuggHXibSLAbH3pKc62tntm6o6tdWo1YNOdrOLXt95qBPOZmKdKMcuksQD0tLy8IDbxr8bbJdvzFv0bL/szJ1/vwU90lRATKnMa7MYk7Wp3iqHrtB/+9yLOhr1OhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762700228; c=relaxed/simple;
	bh=nprdIRXZrqbmOui3PZEs7WLXmXjMO/Ll0+bxtT3szk4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNriZuMKPRh2Sap7Y1lSCLc+pHngsjBqf+YAvZv9kyJAg1hRAJErtQpA0IrDh0IA3lL8E0PnIjqSePCiD/6D09g5EpbZ8Gs918BMT3+Y/x50enPHCx62U1i33nvQZRcZkWGVSPei3NWvObj7PcrQ8KlCi1sA0yXquk3Rze2FnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ate3ywjE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA98C19421;
	Sun,  9 Nov 2025 14:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762700228;
	bh=nprdIRXZrqbmOui3PZEs7WLXmXjMO/Ll0+bxtT3szk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ate3ywjEpmn5rCCKzT+4uoPFLOWNqdcbGsIoE7lshvzVjV2e7aRodNQgdMxv6a1TX
	 pErBAzROb2niLHjP8u9uP61IVr6VbdYq9PeXn+RpSetQ1+XHI1Zkf32yOpZ7c5Vwq5
	 7rL7ipQeaEh9qU33dRnDAvgosiglVbMteayOiAXPcJTHAknzFWLAfLAgufPaqFiQmv
	 ZTYmzcWljdWQ4DmNAK2mNR8vSc2Tez1u9/zlHj0g6/lGF2jUNpKcDZGdX9cvNVbeLG
	 UzjrioXHEGR3PAnwsD92EHuQfVsodW6XQQGFlOHI3khUrZLe5VSfflDKMldrbVnSV9
	 96wDTf1+czQ+A==
Date: Sun, 9 Nov 2025 14:57:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>, lanzano.alex@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: bmi270: fix dev_err_probe error msg
Message-ID: <20251109145702.510c6276@jic23-huawei>
In-Reply-To: <aQhf15IWlTMfETpf@smile.fi.intel.com>
References: <20251102223539.11837-1-rodrigo.gobbi.7@gmail.com>
	<aQhf15IWlTMfETpf@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 09:55:03 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Nov 02, 2025 at 07:30:18PM -0300, Rodrigo Gobbi wrote:
> > The bmi270 can be connected to I2C or a SPI interface. If it is a SPI,
> > during probe, if devm_regmap_init() fails, it should print the "spi"
> > term rather "i2c".  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the togreg branch of iio.git. I'm not in a particular
rush to get an error message fix in so this can wait for the next
merge window.

Thanks,

Jonathan


