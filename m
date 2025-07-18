Return-Path: <linux-iio+bounces-21766-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5B3B0A189
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 13:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0376A87734
	for <lists+linux-iio@lfdr.de>; Fri, 18 Jul 2025 11:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B182BE640;
	Fri, 18 Jul 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEEIA2Ub"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE529B78C
	for <linux-iio@vger.kernel.org>; Fri, 18 Jul 2025 11:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752836712; cv=none; b=GkJ1S414gR57W6fqr+ajhznbWnLA2vooJ1u5EDLIvYijLSWZQqkRZWI5vkVo81XC97/bKt1yjms2KIm3ZdiPzlrupMkC2T8in5oU6bSglUqSpKa19vrTh8u34ed+mqU3YX2315qn6JUOblfDET8SX16EWyfGRHCrbi5a0oc+cv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752836712; c=relaxed/simple;
	bh=WchEo6ffw7nNQqTeWDIdkSuBmkNCAdnTWkys0+zwmvM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gzEfIVCjJI7AIVw4SnGN+cXv26ZsPtHzNzv50xxEgJ6yyVU0W+16YkbOTe+jxYE7Yl4iXOAMT4Id4FPhXr4I8jiJQP3nkYpTxPlT0F1I94ZytNz8UCOhwNZ7zvy4rcdf8C6Ej/eD4NbrxqIS1eIBRFVZyolh6CoSfvhC0y1+uHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEEIA2Ub; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4193FC4CEEB;
	Fri, 18 Jul 2025 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752836711;
	bh=WchEo6ffw7nNQqTeWDIdkSuBmkNCAdnTWkys0+zwmvM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=nEEIA2UbpfJN3BBIpv6zXsxxS5HBp1dUMxRMyRDKBGz0zOE2YcBF0DN04KMdzBtaU
	 apHJ308F9HSpWhapcZveZ8s4dG32Wp5Q/Da2WvhHBNn1nbQmpgl9tV+/aB/dcrQPXU
	 YKMsTSxqzLW4rJRduvUm1HbL2iDF585PCTS9VSUYJXBV/kj6i/aXpP2KiPZam0C7Od
	 JnSS4DuFDYIZmvta1gku2xgZ6O4u0CuzC4mO4Ke0a0MCTxfapHuM1DSNK+mrek1ap7
	 AUnm7UnuVhjsnhZp44sETtPIaOeap8BI0rGs5QrSAXFFn3m3uqbhPsEdgB8mvcc7q5
	 2DA88OoFmZ0hQ==
Message-ID: <f66d26d4-64ff-48a0-a276-060aad3b4d04@kernel.org>
Date: Fri, 18 Jul 2025 13:05:09 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: Add Intel Dollar Cove TI PMIC ADC driver
From: Hans de Goede <hansg@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <20241219230028.55987-1-hdegoede@redhat.com>
 <20241220194249.434244e0@jic23-huawei>
 <a0d1bcf9-74e1-43cb-9f4f-1fb6f5b20724@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <a0d1bcf9-74e1-43cb-9f4f-1fb6f5b20724@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 18-Jul-25 12:56 PM, Hans de Goede wrote:
> Hi Jonathan,
> 
> Thank you for the review and sorry for being quite slow in
> working on the next revision.
> 
> Note this is really part of a fuel-gauge setup series,
> so for the next revision I'll include this driver in
> the upcoming v3 posting of that series (it can still be
> merged independently from the rest of the series).

<snip>

>>> +static int dc_ti_adc_read_raw(struct iio_dev *indio_dev,
>>> +			      struct iio_chan_spec const *chan,
>>> +			      int *val, int *val2, long mask)
>>> +{
>>> +	struct dc_ti_adc_info *info = iio_priv(indio_dev);
>>> +	int ret, ch = chan->channel;
>>> +	unsigned int lsb, msb;
>>> +
>>> +	if (mask != IIO_CHAN_INFO_RAW)
>>> +		return -EINVAL;
>>> +
>>> +	guard(mutex)(&info->lock);
>>> +
>>> +	info->conversion_done = false;
>>> +
>>> +	/*
>>> +	 * If channel BPTHERM has been selected, first enable the BPTHERM BIAS
>>> +	 * which provides the VREFT Voltage reference to convert BPTHERM Input
>>> +	 * voltage to temperature.
>>> +	 * As per PMIC Vendor specifications, BPTHERM BIAS should be enabled
>>> +	 * 35 ms before ADC_EN command.
>>> +	 */
>>> +	if (ch == DC_TI_ADC_BATTEMP) {
>>> +		ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
>>> +					 DC_TI_ADC_EN_EXT_BPTH_BIAS,
>>> +					 DC_TI_ADC_EN_EXT_BPTH_BIAS);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		msleep(35);
>>> +	}
>>> +
>>> +	/*
>>> +	 * As per TI (PMIC Vendor), the ADC enable and ADC start commands should
>>> +	 * not be sent together. Hence send the commands separately
>>> +	 */
>>> +	ret = regmap_update_bits(info->regmap, DC_TI_ADC_CNTL_REG,
>>> +				 DC_TI_ADC_EN, DC_TI_ADC_EN);
>>> +	if (ret < 0)
>>> +		goto disable_adc;
>> Always a corner case of what to do about disabling when an enable fail.
>> We'd hope it never happens but in general I'd assume no side effects occured
>> and return here rather than the goto.
> 
> Ok.

Correction, the goto is needed to undo the setting of
DC_TI_ADC_EN_EXT_BPTH_BIAS done above, so I'm keeping this as is.

(although it is ikely that once we start getting register update
errors doing more register updates will likely also fail...)

Regards,

Hans



