Return-Path: <linux-iio+bounces-23905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E956BB5023D
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 18:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 832E83B09A3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Sep 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D7F2D3ED7;
	Tue,  9 Sep 2025 16:15:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6025A655;
	Tue,  9 Sep 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434519; cv=none; b=H90QVswdQd0nNAgbONC9EpvQsRl8VwKf5wTiMVKRNmbVQOE4ukQ3DYsBm3FTsGjrfmJhp98w6aWkzktZBLtBhkWTKQiq0YguOtR+twm75JDrolLtlNMz6AfQF74/zyIPCu55/1uF8mkL+lUCP/4kycxeiB0eVCEQUx1gv+B13cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434519; c=relaxed/simple;
	bh=g1BBk7blSEDlIQ6ruqfc7rmqsfjdX0Ln/dCUsd2TbS4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyLQpEnPITS/PAduPfz/jU4jSniV7ZUVmxDWMkfiLJMGcv2EIDbSCPDCP2zGbEA6PXZMH0Gwg3xqHL+aPFpbfQ5GZfV14ZAMbyD8czMno4WfjeLEUyb0PBpEbyxQDqZBFrUxu58DI0WAq3mWc/Kz0vFAQMB7Lpd2eEH4p22BmsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLphm0WTwz6F9Bm;
	Wed, 10 Sep 2025 00:11:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C1363140279;
	Wed, 10 Sep 2025 00:15:11 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 18:15:11 +0200
Date: Tue, 9 Sep 2025 17:15:10 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>, "Nuno
 S??" <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 03/10] iio: accel: BMA220 migrate to regmap API
Message-ID: <20250909171510.00007b30@huawei.com>
In-Reply-To: <aL5NCVh9WylPhZ1O@sunspire>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
	<20250901194742.11599-4-petre.rodan@subdimension.ro>
	<20250907134506.580de654@jic23-huawei>
	<aL5NCVh9WylPhZ1O@sunspire>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 8 Sep 2025 06:27:05 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> On Sun, Sep 07, 2025 at 01:45:06PM +0100, Jonathan Cameron wrote:
> > > +static int bma220_reset(struct bma220_data *data, bool up)
> > >  {
> > > +	int i, ret;
> > > +	unsigned int val;
> > > +	guard(mutex)(&data->lock);
> > > 
> > > +	/**
> > > +	 * The chip can be reset by a simple register read.
> > > +	 * We need up to 2 register reads of the softreset register  
> > 
> > May need?  Given you return early if the first one succeeds. If you actually
> > need two drop the loop and only check values on second read.
> >   
> > > +	 * to make sure that the device is in the desired state.
> > > +	 */
> > > +	for (i = 0; i < 2; i++) {
> > > +		ret = regmap_read(data->regmap, BMA220_REG_SOFTRESET, &val);
> > > +		if (ret < 0)
> > > +			return ret;  
> 
> I'm not sure how eloquently I can explain this. the sensor can be in
> 
> sleep state / non-sleep state
> reset state / non-reset state
> (these overlap)
> 
> the sensor toggles between these states when the master reads the suspend and
> the soft_reset registers respectively.
> based on the value read one can tell what was the previous state the sensor was in.
> 
> bma220_init() simply places the sensor in the non-sleep AND non-reset modes (and
> resets all configuration registers so that we start from a known initial condition)
> 
> 'may need' is used because the sensor might have been left in an unexpected mode
> in the previous session.
> we need at most two reads of a register to make sure bma220 ends up in the state we need.

Fair enough.  That is obscure and generally weird. 'may need' seems a valid short comment!

J
> 
> best regards,
> peter
> 


