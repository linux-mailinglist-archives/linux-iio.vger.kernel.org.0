Return-Path: <linux-iio+bounces-27252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E385CD279B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0422B300A6ED
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A22C21FC;
	Sat, 20 Dec 2025 04:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cutfLsFW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1F23507B
	for <linux-iio@vger.kernel.org>; Sat, 20 Dec 2025 04:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766206204; cv=none; b=R/Q/1DJ1X6LUVU00dZU7dEE7K1zXEfpNeaih5ZDbL8zkusqL0/vc4Y6trHzirrnNn1Z/rOueE6VhEfFDcES1lq2WmJLbqsPbyV/Zrkm9UHjj/UJRv9Ejw4RiJ7uLAad9XoPpNBD+gO9tqrDlUuYlNzAUUkS4svJUiozZCTuFxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766206204; c=relaxed/simple;
	bh=ye38Hdc3TN4wC7kPBPlwjQEazbdh3rj+kKaX37eaT3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgB5Zq7fQa0U+6VQPFIUmHNVGLQQujFrvJDn9zY2AS+UOTZfZAY+4tA17z9MDr6eAdberjrugMuX3+k3rip32dcNYSWNSlKtwoubZfNkGQ5gYeY4ji0poTLH305WzSRvKgU6EPgvZaYg1dX83cYoC5Dh6+v7jE8FXeZvXruqRIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cutfLsFW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1538174a12.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 20:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766206202; x=1766811002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E9Df5HtBYd3U6BIrEz3tWZN0YoXGwv6Fg5H18R/j+eU=;
        b=cutfLsFWgbs7ql4khR0AN+Qidhi8J0Lt0j9h/T27fRrHHdw4UV/Zk5i6N+2VkvEDEN
         yuH5ZviE5KlZzgFb4TUO4sKffs+sss192mI56ntuSUlgfACPdAFuYe6xSc4/Y6Rohu72
         WZHnp9qpQgfOhgpR6o/0Y0B4vtCFk7QpyxwHwLQceMTCgRO6zNO4FUWRd4rA29jqJnPn
         JqgN3IwTlRUh5VVmqfYpV+qGR9IpOyFvBdYye3hMVeOFJ9w6YLBez3FE/2Ho/P26emvC
         yC+R/6nVqyStzIPFg986+YS6QSquS1okamAnd2HvlrqUoS6R6e5YcFGSq6ba32/P5cgx
         4lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766206202; x=1766811002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Df5HtBYd3U6BIrEz3tWZN0YoXGwv6Fg5H18R/j+eU=;
        b=KxJRNS/Dul+cd5hbr3XLImhs52P8eAwET7CGEykOsZchOmlbOvpDwvk5U5PdWN8LJ2
         XnLoG7xHx0IvQLWxUL/GN8zNBQEPlJkJjMZ38zA4xmINDIT8YVu45tML25onklWuVZnw
         gWFGsJqr0cdL/baEP9ZQje6vyiVP0XYG+6neP/MvojKAIlPTi6lxuUAGZFimg7bGAYvp
         aPLy+GzYT/xPxOPAelMcMq0OIUS06tjWznkfKc3sXGjeEX74dZ5LTT5KYTaOIbK2HK1s
         OyL0+xLfgOojuJhxjnUhCTO58AuTPieX4FRL/ir9Xg2oAM1savfQeIRM1jxh2VDdG8dl
         Aphw==
X-Forwarded-Encrypted: i=1; AJvYcCUTD2EtLjoKtlkrhNZLE5650ue5yHNUkkYnm8McpPSgAhRDFqAIlKy4gj8FbbI5W4GnjpqwC/gNK68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQH59avBrCqZbEwQNK+G5YW+N0yRSgJJRnYomCWqE4ki0MJGu
	GjFmi+dgVwIvZYLOcqXQdBs1ZqZ/WxlIuUpXKN2Sa5kxnwUAAGLUFi0w
X-Gm-Gg: AY/fxX4so6vikw/+eSII4RBI6hzznWnGHscLVQ9AkaqvJnZv5sLy6MHN03/uBSaD0TB
	0KmzgpeEg5fbTJp3H8mqZfb5883y8JC3ZlEPw37s4k0M8irDuUKng8JMycdy12CJ/CNebWsyjo7
	rRiSc4sgX8+TMGI/P4lEMYm9JWyHR4Fn6eWS7Nko7Lc2FE92l75PnbYiBAPLE3T7U1ImwnZkJNl
	0TU6NuurJq18NOmGd/Ep4ZBfxQsP4+ZRUv6sXn2ntYgLhtYVcFH7uu5UrE3X+L7RApwCIdhrWXQ
	lJDj0yHYMN6pXXkrpRvEiuMme89TaHaN1i1bMjDwq+AtYMxYNle+lEKzYQzvZzk5ECKCxSkIsCQ
	ROZ7jqw6rFl/x3xzELRPpMLwsKm5l+rfXYmjsM5UIwbvfcfnu1Cf63etqdA4HLDQ+AZVwViS9Sq
	EMfepGCa13EIdxiXyaV7I=
X-Google-Smtp-Source: AGHT+IGKDKZ2YvURwANe4Jw0Ne6tXOG8y9cfcKfxt/Zkd78XnzdAmbrhdLoCNhUF7xaIS6LCG6v+Wg==
X-Received: by 2002:a05:7022:689:b0:119:e569:f620 with SMTP id a92af1059eb24-121722e13ddmr7273248c88.25.1766206202126;
        Fri, 19 Dec 2025 20:50:02 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c0c6sm17162809c88.12.2025.12.19.20.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 20:50:01 -0800 (PST)
Date: Sat, 20 Dec 2025 01:51:42 -0300
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
Message-ID: <aUYrXpyaM6YdMfUd@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-9-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251218-mprls_cleanup-v1-9-b36a170f1a5c@subdimension.ro>

On 12/18, Petre Rodan wrote:
> Based on the sensor datasheet in chapter 7.6 SPI timing, Table 20,
> during the SPI transfer there is a minimum time interval between the
> CS being asserted and the first clock edge (tHDSS).
> This minimum interval of 2.5us is being violated if two consecutive SPI
> transfers are queued up, at least on my SPI controller (omap2_mcspi) [1]
> As you can see in the first package that only contains a NOP the interval
> is 0.75us (half a 800kHz clock cycle).
> 
> This patch mitigates the problem by implementing a different measurement
> technique that does not involve checking for the EOC indicator before
> reading the conversion, thus making sure SPI transfers are not queued up.
The correct way of fixing that is with protocol specific delay. Generic delays
like fsleep won't guarantee any delay between CS drop and fist SCLK edge. 
For SPI, we unfortunately we don't have any interface to set a pre-SCLK delay
so I suggest to make an spi_message with a dummy transfer to cause the initial
2.5 µs delay. E.g.

/* dummy transfer with no data, just cause the delay */
xfers[0].delay.value = 2500 * NSEC_PER_SEC;
xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;

/* normal data transfer  */
xfer[1].tx_buf = data->tx_buf;
xfer[1].rx_buf = data->rx_buf;
...

Also, I don't see how the proposed change is 'implementing a different
measurement technique'. Consider updating the commit description or providing
better explanation.

> see Option 2 in Table 19 SPI output measurement command.
> Note that Honeywell's example code also follows this technique for both i2c
> and SPI.
> 
> This change only affects users that do not define the EOC interrupt in the
> device tree.
> 
> Remove defines that are no longer used.
> 
> [1] https://pasteboard.co/66WN38MRI1wc.png
> 
> Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf?download=false
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

