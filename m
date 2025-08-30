Return-Path: <linux-iio+bounces-23474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D5B3CD9D
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159E67C4385
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B09925F96D;
	Sat, 30 Aug 2025 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBSOXbLF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE8DDC5;
	Sat, 30 Aug 2025 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756573220; cv=none; b=KCK7cfvjtSRJh7c2u8G0z/6LcAIHVhWs2tBWhpRD1HYKPVQ5pQExfwnm+yKl6+KT4KqdvVhn/pL7q5hmqXMGP8hemK+abEkWVXj5JZQaiMe12gqJttMdgUkP0PjDvKCfcza8OL0zztUZ8JezkY3cI5hT5jVq1Yxu/EBN8Js4h5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756573220; c=relaxed/simple;
	bh=VPJx/F4bsJNokRYP1Ib3J1S/QH1A+7PugITsWfsa1BY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omT9Knp7UOB1fwievdn+FO1uMhKzrazWT1fjZclNbF5pxZkD+10G9oFkN1v5JP0LiUy3ItMH7WlE9sRZ8qCYNl/jd9n3r8FrOcpl35QKurmhjzmkCqPYzH62V52ZCRLr79xLGbgvNim50+hElO2sjT4USk7+itE3RE4T+vGpBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBSOXbLF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10589C4CEEB;
	Sat, 30 Aug 2025 17:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756573220;
	bh=VPJx/F4bsJNokRYP1Ib3J1S/QH1A+7PugITsWfsa1BY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dBSOXbLFCLU2b+DPxQf4olnAk8n24lBQ1zs54hRk4AXi7NjOTu0mlfI20ADIx2ziu
	 oOGdARC+cQZyfv+d0vLQyg9BEbozfBJHom0WRFPpdlbUl4x7Ai4eUdGROq3yDv8VPC
	 XZ4H+0y3oBSBpUkV3EaFjzJEA+I5lmAaas1dibQZ4eY3rqRVnnTKfAzogbgnawsamc
	 dvYYrcJUBoeepFVCxPCyzpnXHXlwK8S2SsOZz3CrrPVxZeJIupsrXvIHtTiKgEush+
	 LWK4k4MlyvefN+FpjHEFVTvMvO6xXQpB5KnuIs36sL1oZ2Wt/+mEyo2RlnX4/0iFfs
	 YXmBkCr5vu1Rw==
Date: Sat, 30 Aug 2025 18:00:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, lanzano.alex@gmail.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: imu: bmi270: add support for motion events
Message-ID: <20250830180012.5ab8872f@jic23-huawei>
In-Reply-To: <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>
References: <20250830115858.21477-1-gustavograzs@gmail.com>
	<20250830115858.21477-2-gustavograzs@gmail.com>
	<CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Just picking out one thing to reply to...
> 
> > +static ssize_t bmi270_show_accel_value_avail(struct device *dev,
> > +                                            struct device_attribute *attr,
> > +                                            char *buf)
> > +{
> > +       struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +       struct bmi270_data *data = iio_priv(indio_dev);
> > +       int ret, scale, uscale;
> > +       unsigned int step, max;
> > +
> > +       ret = bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);
> > +       if (ret)
> > +               return ret;
> > +
> > +       max = BMI270_G_MICRO_M_S_2 / uscale;
> > +       step = max / BMI270_MOTION_THRES_FULL_SCALE;
> > +
> > +       return sysfs_emit(buf, "[0 %u %u]\n", step, max);  
> 
> Do we need []? Is it common in IIO? The usual way in SW to have "$min
> $max $step" (see `seq` in shell, range() in Python and so on).
> 
yes. See ABI docs for _available.  It comes in two forms.
space separted list of values and this one which is used for specifying
limits and step.  The [] is how we tell which one it is.

For anything other than events we handle all this via callbacks and
masks. I've never bothered adding the complexity of that to events
as _available attributes are fairly rare.




