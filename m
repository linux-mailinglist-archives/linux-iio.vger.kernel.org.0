Return-Path: <linux-iio+bounces-20307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DE0AD0EAC
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 19:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E67E018905CE
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8701FF7C5;
	Sat,  7 Jun 2025 17:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+O+VVvq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1687F9C1;
	Sat,  7 Jun 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749316029; cv=none; b=jGtd6BwbHhOpqk4GtEuJMZnNqzHg6HH9xLwHhmzUGTlkFZh0CWQyCLPrxadXfo83YtGVJBR6OhFgp55bBFQf/gNBMXbCN2N2EYH1RfKaIrn1LKpZXaUuhBj4UU9MekgaWVLV+Khdsm2GDXKV1JZXYzf9uu2iXn+i3ThLl/u+kkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749316029; c=relaxed/simple;
	bh=Azz48mpCYMvYjRFCNahCCCmGCYAn+g8SuVXJdTJDQRE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ryEXoS3hbV4u35gOuUt6pSWF4IhclxBNz5ec3knI3RLpi/C+ARlUERhXhH8siufkErQGHlaGpzmNwbrXfE7JXjLrPYGsr/AXOsgyKu07jFZaMaErYmh0hpqvgBM8SO36te6OM+bmEZKdo34E6tUhKZ2FWAJaCJudqdZn7UVpy2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+O+VVvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B43C4CEE4;
	Sat,  7 Jun 2025 17:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749316029;
	bh=Azz48mpCYMvYjRFCNahCCCmGCYAn+g8SuVXJdTJDQRE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f+O+VVvqoZnFgHp4UtWWwkXnfxmWbHHt62ws/XtukL3DohEp41faqTsSCABsruJnd
	 X7AaKckZYS8KZxnXGDoUsNdGcT1VtPx/dekv/5xsHpDg674gaq70TWW1x0IpdT7wRQ
	 A14RlLEUh4XmylTnkfNu3dnzQDvP9kSFWNzMeER2gYdzCwMOCWUDlmz/BPjX/qw5jQ
	 TkPeJiXiEzg3UqV7viPXTbVlE/TuMIwoX0VUVcBI7Da62fjxPQYmhIwys6x9qphioT
	 BX1L9wruC1lKpxPujvPhG2gZGDf3YBcUJyQgTUNHdgH6e4rsUI8ERqmHR7oxqKb2At
	 JEZB2+4vba2iw==
Date: Sat, 7 Jun 2025 18:06:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v4 06/11] iio: adc: ad4170: Add support for buffered
 data capture
Message-ID: <20250607180658.7db5271c@jic23-huawei>
In-Reply-To: <1e966af21b33b7dd969e1faa8126159c5dc501f7.1748829860.git.marcelo.schmitt@analog.com>
References: <cover.1748829860.git.marcelo.schmitt@analog.com>
	<1e966af21b33b7dd969e1faa8126159c5dc501f7.1748829860.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Jun 2025 08:38:46 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Extend the AD4170 driver to allow buffered data capture in continuous read
> mode. In continuous read mode, the chip skips the instruction phase and
> outputs just ADC sample data, enabling faster sample rates to be reached.
> The internal channel sequencer always starts sampling from channel 0 and
> channel 0 must be enabled if more than one channel is selected for data
> capture. The scan mask validation callback checks if the aforementioned
> condition is met.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

A comment inline about possibly relaxing the channel 0 constraint
as far as userspace is concerned anyway. Not necessary for now though.


> diff --git a/drivers/iio/adc/ad4170.c b/drivers/iio/adc/ad4170.c
> index 3d83c3ace569..86ef70acbf21 100644
> --- a/drivers/iio/adc/ad4170.c
> +++ b/drivers/iio/adc/ad4170.c
> @@ -13,7 +13,11 @@

> +static bool ad4170_validate_scan_mask(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	unsigned int masklength = iio_get_masklength(indio_dev);

If this becomes a useability issue we could probably generative appropriate
available_scan_masks entries and let the demuxer in the IIO core deal with
dropping the unwanted first channel.  That might be preferable to just
failing if the channel isn't enabled.

As a general rule, I think we've always used validate_scan_mask
to prevent too many channels being turned on, or incompatible sets of channels
rather than to prevent too few being enabled.

Anyhow that would be a relaxation of constraints so can be done if it
turns out to be needed later.

> +
> +	/*
> +	 * The channel sequencer cycles through the enabled channels in
> +	 * sequential order, from channel 0 to channel 15, bypassing disabled
> +	 * channels. When more than one channel is enabled, channel 0 must
> +	 * always be enabled. See datasheet channel_en register description at
> +	 * page 95.
> +	 */
> +	if (bitmap_weight(scan_mask, masklength) > 1)
> +		return test_bit(0, scan_mask);
> +
> +	return bitmap_weight(scan_mask, masklength) == 1;
> +}



