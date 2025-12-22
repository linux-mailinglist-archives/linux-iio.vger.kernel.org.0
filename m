Return-Path: <linux-iio+bounces-27320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEBDCD6616
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 15:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF1DA304BDA2
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FC92F619A;
	Mon, 22 Dec 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePpnRlEU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80562D837B
	for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414074; cv=none; b=k3wroA56yH+S0Z3VtFsOn3vVKXdUPX8VbpEaN6p7moYtvl0RAx5dPatbG/KBoPv6wX8MA3j8nlo84rl9hi+tE3bfVcNsa1oW6cOfElQQ7Lw0SbzYJUdU25UN7qylDT7qvUwbpnoz5IEvX20dBTGhb7FkG5YGKRZbcxud80IMFf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414074; c=relaxed/simple;
	bh=VVD+0oUUv8YmEVwOjP4p2VfnxrSdLXLj4mV1Ezre2oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdPfirAwJt5xIvpL38+XkjFGxvZA4T41FICXFWermsSHWMLe7mxFO6M2xwG1ZTfdgGcNuLmoP18AawPKuXi6SDIdFoH2iy16AKpDk0z9PMCPEyMBlvy/m5A4lJd+K9LDWAkrZy7JB58OHRPGxC3/m/q4Njr0gZIlMhufLUkQ8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePpnRlEU; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so2500984a12.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766414071; x=1767018871; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/k1Q2LIfLpu/c6rykPxJlyj1Xyjpq2ns3QEor2z5jKE=;
        b=ePpnRlEUDepKcPizfZ3hlnzHb5+CMvnB96uKTqkh7UDomkjdG3v2szvag4r9MGsTXp
         iT4H7BOQYizkkl04ZBo7fC49uf8lU6wtMP8cQ6DhnJUjLhEN3w/bm3SWdM29iSPdGZVx
         tYgXGAhfRqfkkBOhkVQS2Tklw+VMOoRcXb8VBWmI6q194cxiqfhkGNLeGumzexIRxZHb
         rdkjog9nHN0m8JnxK8zHaP1lKJgEYL4o7TxZWxPxdnbzUDcKETBpbzeqKcyqkan8T/zu
         Yy678O+2pt2U2bnzbLefV0i7ECp3EezrvSvHQa4oxzfBI7edGjpwEuS5T8/irr3K2fAg
         LljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766414071; x=1767018871;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/k1Q2LIfLpu/c6rykPxJlyj1Xyjpq2ns3QEor2z5jKE=;
        b=CIg5z96sYXMaIUNbwB5ibRbq1hcr57TvNcC2DGuNwk2CVC5yseNvTD7O9nCbyD3UBs
         Z69rDLXGBE9hu1FPWkeLycZGuiehXwOAKYjwPS8RemGfadb9XydQbRN/w5mvELpy5/Mf
         fPCSmuPZ4tqX3CN6euvlgQR/3lIT+LhEugGG7tpYMZ4eb2kF68hcHJGGwi2FlP5Aavbd
         ndjbhXkjvfTdsu8bQYq9qFTJbdLPtsntyO6U0n2FgIAhyzpZC3DBfwnxVkK6gDM1kxrY
         TDc+PKlmZ/dthcTOjiagdXFP+xYZwXpZ8s4KzRyfe66V7m9Kum00I3TzMXNc6p+eHTWD
         wbVg==
X-Forwarded-Encrypted: i=1; AJvYcCXMMS8bkEqYR64BLQod2dGxQ23r99mdXodfaYSYEIs5m8E8aUWwx8Yvqlm1D8/Ssf+bInUUeahuU6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAXMOULJ+6vb3vnkSOM/6W7ROBuuQeaXAgcq+0PhCJxTGmJ6tp
	7LX5NnyiIliTtfqU0HRPRVqqFqvIS0Z2pCfrKzKcPNyhj/ugectLkmuT
X-Gm-Gg: AY/fxX7wrpeD3Pc6bd3/d3wwJ0mXMXNQ/Mts3IhwVv/UV8aXHpR00ffNK+SZfC0RMzC
	R3PLVQzXqikR7APSdyKmi+rRtB6puzxnlPNimhHsSGNCgidWQwnjstgIyslapu5Dfe3mYHW2a+v
	80U6T0PtHHBZVjvlzlLxOaeboc7Pk3mN/KzdcYEN/I3TAFGlaGAOXmoxLFZd9SJDA59PSQ26SPe
	ApQh4ylmT0WHbKxTbJuS3sakYn6l320hdC6E9y1x5R77Iu2VGO2/09KyNhRKoMwIg6OWB+wXvP4
	M68ruU9wSmvl9CmbwoGX8ObgqCtVroXqi8ym/yavpt+xoi3tWnwNsi027mubwkb0COrC2eQekg1
	DnIIoTCc9rR1o5evjS8dgoLTDoR2BEGK2dO/pe49KMgE5MoTW8PLFQhGMO4utjSEsMBchulPLWg
	a5aLcOAsHy8xdgbMWL0TfmrSwhPivHuw==
X-Google-Smtp-Source: AGHT+IFSdZNneiy+OhT2Bpvc8WmLVeJ4BxM5mU6+ql6lup5HyaU6LB8R/6MP7SrQP7Wfn0hiX+5KJA==
X-Received: by 2002:a05:7301:7817:b0:2a4:7b58:1a25 with SMTP id 5a478bee46e88-2b05ec7459fmr7795798eec.27.1766414070828;
        Mon, 22 Dec 2025 06:34:30 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ff8634csm28715254eec.3.2025.12.22.06.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 06:34:30 -0800 (PST)
Date: Mon, 22 Dec 2025 11:36:11 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 09/14] iio: pressure: mprls0025pa: mitigate SPI CS delay
 violation
Message-ID: <aUlXWwoqnG7llPwA@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-9-b36a170f1a5c@subdimension.ro>
 <aUYrXpyaM6YdMfUd@debian-BULLSEYE-live-builder-AMD64>
 <aUZUwL2fHQ6Q4zOI@sunspire.home.arpa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUZUwL2fHQ6Q4zOI@sunspire.home.arpa>

On 12/20, Petre Rodan wrote:
> 
> Hello Marcelo,
> 
> thank you for the pointers.
> 
> On Sat, Dec 20, 2025 at 01:51:42AM -0300, Marcelo Schmitt wrote:
> > On 12/18, Petre Rodan wrote:
> > > Based on the sensor datasheet in chapter 7.6 SPI timing, Table 20,
> > > during the SPI transfer there is a minimum time interval between the
> > > CS being asserted and the first clock edge (tHDSS).
> > > This minimum interval of 2.5us is being violated if two consecutive SPI
> > > transfers are queued up, at least on my SPI controller (omap2_mcspi) [1]
> > > As you can see in the first package that only contains a NOP the interval
> > > is 0.75us (half a 800kHz clock cycle).
> > > 
> > > This patch mitigates the problem by implementing a different measurement
> > > technique that does not involve checking for the EOC indicator before
> > > reading the conversion, thus making sure SPI transfers are not queued up.
> > The correct way of fixing that is with protocol specific delay. Generic delays
> > like fsleep won't guarantee any delay between CS drop and fist SCLK edge.
> 
> sorry for the lack of detail in the commit log, I forgot to add it.
> 
> this patch changes the measurement sequence and as a consequence it also mitigates a problem where protocol-specific delays are not implemented in the SPI controller (for the corner case when multiple SPI transfers are queued up).
> 
> as per the datasheet pages 36 and 41, the measurement sequence can follow one of these two scenarios, for both bus implementations:
> 
> a) send measurement command and wait for the status byte to lose the busy flag.
> this means that we would need to keep sending NOP commands and read the first (status) byte in a loop until the busy flag goes away. this is how the driver was designed before this series of patches.
> 
> b) send measurement command and wait for 5ms for the data conversion to occur.
> same as a, but instead of polling the sensor for the status byte there's just a 5ms+ delay after which only one NOP command is sent.
> the read that follows will get the conversion data plus the status byte.
> depending on the status byte flags, either error out or pass the conversion along.
> 
> my patch replaces the measurement sequence defined by scenario a with scenario b and it only affects users that did not define the EoC interrupt pin in the device tree overlay.
> the datasheet contains sample code (pages 38 and 43) and they also happen to use scenario b, so no polling.
> in my testing the sensor always performed as expected (the busy flag was never set after the 5ms fsleep()).
> 
> > For SPI, we unfortunately we don't have any interface to set a pre-SCLK delay
> > so I suggest to make an spi_message with a dummy transfer to cause the initial
> > 2.5 µs delay. E.g.
> 
> for normal (non-queued) SPI messages the delay that exist between the CS assert and the first clock is ~4us, well above the 2.5us minimum.
> the problem only appears when the SPI controller gets multiple xfers without any delays between them - which happens in scenario a when two transfers get queued up (NOP that reads the status byte and the NOP that reads the status + conversions).

Sure, as you say, the probable reason to have enough first SCLK delay was
because the SPI controller was not initially dealing with many transfers.
Though, can't the MPR read transfer lack enough first SCLK delay if a different
device on the same bus bursts SPI transfers during MPR device read?
fsleep() may fix it for single-device use case, but I don't think it is the
proper way of getting transfer timings correctly. To ensure that first SCLK
delay, you got to use protocol specific delays so that the controller will
be able to properly set that delay.

> 
> this is just a hunch but I think that the CS timing is directly controlled by hardware when the issue happens.
> see chapter 24.3.2.8 page 4903 in the AM335x technical reference manual [1].
> I'm measuring exactly 0.5 clock cycles CS lead times which is the default for the TCS bit of the register MCSPI_CH(i)CONF.
> 
> [1] https://www.ti.com/lit/ug/spruh73q/spruh73q.pdf?ts=1766215152875
> 
> > /* dummy transfer with no data, just cause the delay */
> > xfers[0].delay.value = 2500 * NSEC_PER_SEC;
> > xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
> > 
> > /* normal data transfer  */
> > xfer[1].tx_buf = data->tx_buf;
> > xfer[1].rx_buf = data->rx_buf;
> > ...

See spi.h for documentation of the delays available for SPI transfers. As I
mentioned, we unfortunately don't have a first SCLK delay for SPI but I think
you may get something equivalent with a dummy transfer like the example above.

> > 
> > Also, I don't see how the proposed change is 'implementing a different
> > measurement technique'. Consider updating the commit description or providing
> > better explanation.
> 
> I feel that using scenario b defined above we cure the problem before it happens.
> my patch provides a less complex implementation, it's recommended by the manufacturer in their sample code and provides less code duplication (status byte parsing) with no downsides afaict.
> 
> > > see Option 2 in Table 19 SPI output measurement command.
> > > Note that Honeywell's example code also follows this technique for both i2c
> > > and SPI.
> > > 
> > > This change only affects users that do not define the EOC interrupt in the
> > > device tree.
> > > 
> > > Remove defines that are no longer used.
> > > 
> > > [1] https://pasteboard.co/66WN38MRI1wc.png
> > > 
> > > Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
> > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> 
> best regards,
> peter
> 
> -- 
> petre rodan

