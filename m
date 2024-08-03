Return-Path: <linux-iio+bounces-8210-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A70946A49
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 17:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A30EB210BC
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 15:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683AC1547EB;
	Sat,  3 Aug 2024 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqDYIEQK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226D91547E0;
	Sat,  3 Aug 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697952; cv=none; b=Kr+4NPuN7bKRR/x9ypklMUHgNgXSPEe15w/qenFzusrhP/12xW/nkc0hqOcDz7gx+iF4tE3MLyneAMkn+fXDEVec7/39jRZ2BNDdVhTZ4snln1K7hon65WNjNwnRTFmF4+5Cyv1eE6iTvx6qHeGcQ1OWedIBU9TjIheDno/Arxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697952; c=relaxed/simple;
	bh=hKygohsOdeB7ONXdsjrCJbuO58oXWXkp2aNHcwRceSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VR28s/luiq0ZK0aqVAOAPzUk1YDSBfCoB3Y7NJGavSSl7aTOUGuoLkhdoueozCuLFMjMm9/z3v3L5z99DD3fayuuHuIrftBDLfwXLurmji7PohYtLBLJsDbTrHZ2DXEjUpD8h+7jG2LXp795lIl0Y1DTEtEW+vcvOIrcmbt04p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqDYIEQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11728C4AF0A;
	Sat,  3 Aug 2024 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722697951;
	bh=hKygohsOdeB7ONXdsjrCJbuO58oXWXkp2aNHcwRceSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EqDYIEQKd2oRqXFxDim9V5p/bk/1AbaQ2C6SahaSHkP20Wdo5/vGP8pcKmO1efEJq
	 lcj05rDMqnWZfjqDbGV0/bh7fqY2NjLt+19SzkhS/TnG2eAsMm1jlQ1e86lBNkoVqZ
	 ZPvhxZQtdvdHdd7Ot9pTONdyHi/akA0FpdzHgsqgU9E2S8HzRVhPlnGk98sRdGULlN
	 etTE5A0McSsz/cFmOekb43mb1W7k5QS8qFUpSlmzTaYjHyZghjWQMS6ck0rlbZkyET
	 22SI5AFHPAuOknTKNTnaMZDfWuJ/rO7ogPcL6K+xZPYt82n49nmVwkiV8PDx2GO9j0
	 2eddEsOC8m/bA==
Date: Sat, 3 Aug 2024 16:12:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: <fabrice.gasnier@foss.st.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/9] iio: adc: stm32-dfsdm: adopt generic channels
 bindings
Message-ID: <20240803161222.1f320fcc@jic23-huawei>
In-Reply-To: <20240730084640.1307938-8-olivier.moysan@foss.st.com>
References: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
	<20240730084640.1307938-8-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 10:46:37 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Move to generic channels binding to ease new backend framework adoption
> and prepare the convergence with MDF IP support on STM32MP2 SoC family.
> 
> Legacy binding:
> DFSDM is an IIO channel consumer.
> SD modulator is an IIO channels provider.
> The channel phandles are provided in DT through io-channels property
> and channel indexes through st,adc-channels property.
> 
> New binding:
> DFSDM is an IIO channel provider.
> The channel indexes are given by reg property in channel child node.
> 
> This new binding is intended to be used with SD modulator IIO backends.
> It does not support SD modulator legacy IIO devices.
> The st,adc-channels property presence is used to discriminate
> between legacy and backend bindings.
> 
> The support of the DFSDM legacy channels and SD modulator IIO devices
> is kept for backward compatibility.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>

One trivial thing noted inline.  If you spin a v7 for other reasons
tidy it up, if not I 'might' (if I remember and can be bothered)
tweak it whilst applying, but probably not.

Jonathan

>  
> +static int stm32_dfsdm_chan_init(struct iio_dev *indio_dev, struct iio_chan_spec *channels)
> +{
> +	int num_ch = indio_dev->num_channels;
> +	int chan_idx = 0;
> +	int ret;
> +
> +	for (chan_idx = 0; chan_idx < num_ch; chan_idx++) {
> +		channels[chan_idx].scan_index = chan_idx;
> +		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &channels[chan_idx], NULL);
> +		if (ret < 0)
> +			return dev_err_probe(&indio_dev->dev, ret, "Channels init failed\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_dfsdm_generic_chan_init(struct iio_dev *indio_dev, struct iio_chan_spec *channels)
> +{
> +	int chan_idx = 0, ret;

As in the above function, I'd have slightly preferred these on separate lines.
If that's all that comes up, I might tweak it whilst applying.

> +
> +	device_for_each_child_node_scoped(&indio_dev->dev, child) {
> +		/* Skip DAI node in DFSDM audio nodes */
> +		if (fwnode_property_present(child, "compatible"))
> +			continue;
> +
> +		channels[chan_idx].scan_index = chan_idx;
> +		ret = stm32_dfsdm_adc_chan_init_one(indio_dev, &channels[chan_idx], child);
> +		if (ret < 0)
> +			return dev_err_probe(&indio_dev->dev, ret, "Channels init failed\n");
> +
> +		chan_idx++;
> +	}
> +
> +	return chan_idx;
> +}
> +

