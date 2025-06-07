Return-Path: <linux-iio+bounces-20308-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF6AD0EB5
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 19:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08386188FF4F
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C06D20E00A;
	Sat,  7 Jun 2025 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFNfW2Ws"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C020C00C;
	Sat,  7 Jun 2025 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749316540; cv=none; b=N84qOtZttG5+xx8C9pxnGtfNdJa8zWui/0k03ZoU6/oL+GgbRSD7EGldV7hInWMW1o2Qml7MXkh5E1X1XHMUv1YzVlP3abbJct/eYehsbHSix5DPKEtIXm4GE5V2BrrwP6MztvGNehKiPrZp74SUAGHHf6K5VRFSRU2E/mvYfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749316540; c=relaxed/simple;
	bh=JZeovyW0oPCnudDGcZApSPCDD26oUm3cgZDBKl/qfjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3PADp1AgWvCKI/umHUKUjvLxMvBGK84Csbsfk40H6VResfg5O1mNJdrSLf3bNkuYXNIT8XuiJz8zzSItfD8NEka3FS0KamGBRqQoqedEvZ41fttBgFOgg7Q3Wfiy95WOLZsfZpt/e5ZHL7LTd8O2B50ECORHVENqGTn5ywLMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFNfW2Ws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B672C4CEEE;
	Sat,  7 Jun 2025 17:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749316539;
	bh=JZeovyW0oPCnudDGcZApSPCDD26oUm3cgZDBKl/qfjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YFNfW2WsGRdHKzc/vyk7nfrKLNSR4lBF6D7alGU5O94rGyZhe5M7OP+Dk3scjvkFq
	 lbWOuug5KdpUjQsavfxHtbJQWWh/8ngNdOo4ZKnQzwHPOylnhllnG1ZDNrlp6Hq163
	 yozneHXlHqqCyl54C2hUeYVN+muaRsrm/fzBVs13bxgNZxRcwANwPMQLfRVVW8o7iR
	 vpIz41xvNuomAulzMEYH6km0UWfET9fNr/9PSgBdemhamVHBPAm7LNXuf8yTCtcD0y
	 j5bN9KWqsZS/3KcaLqOANWDcgqJDrt3jRcge3yCsg4Arm8Fk3K/6SZvu9ibib19XcB
	 +iUi/NhPG7DzQ==
Date: Sat, 7 Jun 2025 18:15:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v4 10/11] iio: adc: ad4170: Add support for weigh scale
 and RTD sensors
Message-ID: <20250607181530.33d4972b@jic23-huawei>
In-Reply-To: <0633d4c716e12c92b7b49a06efdbbd8cd1ef19c0.1748829860.git.marcelo.schmitt@analog.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
	<0633d4c716e12c92b7b49a06efdbbd8cd1ef19c0.1748829860.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Jun 2025 08:40:01 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The AD4170 design has features to aid interfacing with weigh scale and RTD
> sensors that are expected to be setup with external circuitry for proper
> sensor operation. A key characteristic of those sensors is that the circuit
> they are in must be excited with a pair of signals. The external circuit
> can be excited either by voltage supply or by AD4170 excitation signals.
> The sensor can then be read through a different pair of lines that are
> connected to AD4170 ADC.
> 
> Configure AD4170 to handle external circuit sensors.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Trivial comments inline.


> +static int ad4170_validate_excitation_pins(struct ad4170_state *st,
> +					   u32 *exc_pins, int num_exc_pins)
> +{
> +	unsigned int i;
> +	int ret;
> +
> +	for (i = 0; i < num_exc_pins; i++) {
> +		unsigned int pin = exc_pins[i];
Is the local variable useful?  
		ret = ad4170_validate_excitation_pin(st, exc_pins[i]);
seems equally readable.

> +
> +		ret = ad4170_validate_excitation_pin(st, pin);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
>


>  static int ad4170_parse_reference(struct ad4170_state *st,
>  				  struct fwnode_handle *child,
>  				  struct ad4170_setup *setup)
> @@ -1803,8 +2268,9 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
>  	struct ad4170_chan_info *chan_info;
>  	struct ad4170_setup *setup;
>  	struct iio_chan_spec *chan;
> +	unsigned int ref_select;
> +	unsigned int s_type;
>  	unsigned int ch_reg;
> -	u8 ref_select;
Why the change of type?


>  	bipolar = fwnode_property_read_bool(child, "bipolar");
>  	setup->afe |= FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
>  	if (bipolar)
> @@ -1843,11 +2327,11 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
>  	else
>  		chan->scan_type.sign = 'u';
>  
> -	ref_select = FIELD_GET(AD4170_AFE_REF_SELECT_MSK, setup->afe);
>  	ret = ad4170_validate_channel(st, chan);
>  	if (ret < 0)
>  		return ret;
>  
> +	ref_select = FIELD_GET(AD4170_AFE_REF_SELECT_MSK, setup->afe);

Can we do it in the patch that introduced the code rather than moving it here?

>  	ret = ad4170_get_input_range(st, chan, ch_reg, ref_select);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Invalid input config\n");

