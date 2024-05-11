Return-Path: <linux-iio+bounces-4950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005648C30D8
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 13:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2331F2130F
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2024 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF2E54F91;
	Sat, 11 May 2024 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2GkE73F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14822F26;
	Sat, 11 May 2024 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715426844; cv=none; b=t0eCiPscx7b/kAAJRhM3nUtC1YWMa4dwNLjI4hWzBL4QHZo/iaWsAlu3P6PkpgnT6v8x31m9F+cEoJZzOVuO08m7lVQzUhgBw4Vt+onS3oJYwG0mKczBolYrWSbs8cTv+L16lAOr2raO6DV1yMdRgMXylilC8tTcbdNfWQmE7zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715426844; c=relaxed/simple;
	bh=cLCZ4jToTqkciTsy8QBqqHWI/zM1DZ9FtzabW+MzE48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qL5rti8acOoyG3ujyEu7SDFkIzXzTg90EOBBTwm/1YiqRujrhwdW4VNfPW2Jza4bVun90hsMDRDWnDZEX+PQVdOlzFuGs/bELZ4SS8/QKczlwipVYSxDvAlEV3n94+L4o0mjiUJRZTpsg6sC/ltSDt8OWSUiK23jSmMRYL2HF7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2GkE73F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC6BC2BBFC;
	Sat, 11 May 2024 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715426843;
	bh=cLCZ4jToTqkciTsy8QBqqHWI/zM1DZ9FtzabW+MzE48=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o2GkE73FrAa/+XpTYJt769JLx61wNiPupSK/TSVabLktm7Y1yWVICyXwKBuWRZFEB
	 Gvuh7khf85hCHpGHrhiM9idlCTh8gXErvNGRw/tXNzKwVh4RTEzaE5vfNuAYMGhBWd
	 2XQ5y3yPydVXdH+W6dLNMnKQxojBHGrS34FKfzks5QWrsaJEmgGkgpP82EWjsk2/qf
	 KoRWzeytA0mIIAphSCuxi1hfow9NEMRQtmcd1tg1pkrpkhf9e5QY/VYnzi3Noe4lEH
	 fiv3MqYSislw5yrsWsvp4G7g3gZ1QQtLxxCxSJzX+JlKd3zihZUwygJcITMS0zhKd6
	 87fiD6Sx9Cdxw==
Date: Sat, 11 May 2024 12:27:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH 7/7] drivers: iio: imu: Add support for adis1657x family
Message-ID: <20240511122708.68fac075@jic23-huawei>
In-Reply-To: <9f0a8fdb-dd34-4a53-948d-d4ed0410de6f@gmail.com>
References: <20240426135339.185602-1-ramona.bolboaca13@gmail.com>
	<20240426135339.185602-8-ramona.bolboaca13@gmail.com>
	<20240428154523.17b27fa8@jic23-huawei>
	<9f0a8fdb-dd34-4a53-948d-d4ed0410de6f@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 May 2024 17:32:34 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Hello Jonathan,
> 
> Some explanations from my side.
> 
> >> @@ -437,6 +467,130 @@ static int adis16475_set_filter(struct adis16475 *st, const u32 filter)
> >>  	return 0;
> >>  }
> >>  
> >> +static ssize_t adis16475_get_fifo_enabled(struct device *dev,
> >> +					  struct device_attribute *attr,
> >> +					  char *buf)
> >> +{
> >> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >> +	struct adis16475 *st = iio_priv(indio_dev);
> >> +	int ret;
> >> +	u16 val;
> >> +
> >> +	ret = adis_read_reg_16(&st->adis, ADIS16475_REG_FIFO_CTRL, &val);
> >> +	if (ret)
> >> +		return ret;
> >> +	val = FIELD_GET(ADIS16475_FIFO_EN_MASK, val);
> >> +
> >> +	return sysfs_emit(buf, "%d\n", val);  
> > As below, might as well put the FIELD_GET() in the sysfs_emit rather than
> > writing the local parameter.  
> 
> In all instances where I did, I did it to avoid casting. v2 inlines the values and
> the cast is needed to avoid compilation errors.

I'd guess that is because the type in the sysfs_emit isn't the same as FIELD_GET()
returns?  That will correspond to the type of the ADIS16475_FIFO_EN_MASK
which is defined as UL I think. So just use %lu here instead and need to cast goes
away. 

> 
> > 	  
> >> +	if (adis->data->burst_max_len)
> >> +		burst_max_length = adis->data->burst_max_len;
> >> +	else
> >> +		burst_max_length = burst_length;
> >> +
> >> +	tx = adis->buffer + burst_max_length;
> >> +	tx[0] = ADIS_READ_REG(burst_req);
> >> +
> >> +	if (burst_req)  
> > If !burst_req does the rest of this do anything at all?
> > If so flip the logic as
> > 	if (!burst_req)
> > 		return adis16475_push_single_sample(pf);
> >
> > 	the rest...
> > 	return spi_sync(adis->spi, &adis->msg);  
> 
> The update is needed even if burst_req is false. The adis message has to be updated
> based on the burst request value, which is then used either in 
> adis16475_push_single_sample or in spi_sync call.

Which update?  The content of tx[0]?  If so that is non obvious so definitely
need a comment. Perhaps even wrap up the update in a function with a name
that makes it clear it's changing the adis->msg.

adis_update_msg_burst() or something like that.
> 
> > 		
> >  
> >> +		return spi_sync(adis->spi, &adis->msg);
> >> +
> >> +	return adis16475_push_single_sample(pf);
> >> +}
> >> +

Jonathan

