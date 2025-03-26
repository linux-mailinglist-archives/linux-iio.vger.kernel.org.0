Return-Path: <linux-iio+bounces-17276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E77A723E8
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 23:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D38E3B6E0F
	for <lists+linux-iio@lfdr.de>; Wed, 26 Mar 2025 22:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28452638AD;
	Wed, 26 Mar 2025 22:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsabKr+8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CAE23FC68;
	Wed, 26 Mar 2025 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028035; cv=none; b=bCGfM/VmOamhZfrxZbKpOxWIEjJb6OhT/o+azb+Zw2jnguE21HQGmKfv+sxUVkfuwvZDJeelexsiH0pVvY/F8YvOlhWPESnjLh0Iosm7TosNRmUNaVUbfPVnn2S7ePPiQ4f0o3IAnGSqADYwvKpkOYQMOrQgWdOVJvkdzv3c0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028035; c=relaxed/simple;
	bh=Cg31gcloS20i38aytFkyiYYXihpkTfoCeFdfxAFrHBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kst/advMcqqKDL4RWQ3iUbvo8hB6DCvywBtUyx4Wc1fj+g841Ag/f5PJf/gtot0cC8UouHVeimSKdPlAPS28O2dd7LKh9jgHLlV+fmD0TcuIa6FiZn2dTGKFpvqp026LPSUU8QtJMpK5PprSuW+nvaSb5Lm7BPX7urRJUlRFrNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsabKr+8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224171d6826so9261445ad.3;
        Wed, 26 Mar 2025 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743028033; x=1743632833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNiFJYuqC4TWb0blkWVovRiBin8ce70LYV9sPG1m0Ks=;
        b=jsabKr+8FM1Gmb40BvHbC1zMNFLdDioA540fUdPOLkIMBlYh7ugjjfXH+inQ8cHeeh
         jNU4vCH5RriTT9jNfOkm00A5dAiakJTA+dc4mYNXFOUMlbdQBV+knD+89BK5l7kLDQA7
         Ejxg5r9RqwRrQVd3FRlcuWr+9/2Z9DQXMhKNjR1yX4oQNHG31yEwpq56cHKaBK5AMWVH
         zYdoDHRkCc/4OrKFZXDODh5IpPjLwy6S+guhp6PoAnplILXnDP6bvLke6WnmZiPli6lI
         IqYP2NYvqHcSmO/HfP6VS/q9zBtCbvv8p73MKNRwDn2HDOFAH8MHlwLmeVc39Yz8K2C7
         B9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743028033; x=1743632833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNiFJYuqC4TWb0blkWVovRiBin8ce70LYV9sPG1m0Ks=;
        b=p3EIJt4J+2fGzDRfqEe4JnsKx2AO2nq1LKxwPOtqKfkoXgs3X/ZiB7HNvQDPMaAvEN
         31DA/a3shMFUBOKsfnhYzRgsN+qKL6YcR35lqH8UjNMlmJ4ryYG53ppT4B6kEIxhIIk7
         50HqAlva2eX1a6SAKOuhHpGnfJ06sEbxMCiGTRvqjSu2i72kEhAFWPZyaMcNWhCEtRhC
         zmb2hyT7t4kyTErzwVIw7XlcBnyf6Z1gEuFZLf4QoinH446hlPHPpwGZh6Gju7GJQS3x
         zEiEPXcKs29oARKscJ3jpUtwz+4HvucMI4pWFCpfr2pIKxvUyjnsvyh5eSoJSsM4ciA1
         0LOQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8XUQLEyazv/VSNQPsgpTfVS19CEQ5ylWvjx4NP6sgRnocIKk7qgJZvQgB99bt6bkHb2eIzFAvh4uuuVKo@vger.kernel.org, AJvYcCV+pfqhonb4dsh56tJtRPWNM0PniNhfbOib5Yo4lU0MoMmfk1tQkqeWL1hi7pUYWoOZHFOcVXFZXWg=@vger.kernel.org, AJvYcCV0uSXjyAq2ytVJa5lgyGRzdgb4pf33zQK0FmD+sjjYk7sZVyxm8Dlogeqe87NojNh/EXZxse9x1vqs@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIY0V4cZYtTDoMZxgWSUzK+RjL3s9KPyyc3wuWQkGtCHciWVa
	I2Spp+PUSGblvbHqkgntT5r4SEy01yU284JdVlxSaSLhjJgpdOSZ
X-Gm-Gg: ASbGncuzzIv6rIbzd8wfVK8gvBsjiHeuVjF/YHqT1bZEaCH6/vcEnAX42oYdNRBtx8t
	v72cXI9HtTVz4jMd+o5izmZHmV/Xwvt/8pK+UC8fei4zSbfiY0lBPEugk3sVKCtuav6QfUkxq/E
	ADhTZiP1f39hmcN44H0tgGFVedkRa0cCkgDNAB/bI6oosAOnOBZM7CuRr4Pr1KWcEc95v982lcc
	82RLcyZxvwkPsXoo7wli0Km6a6UorUNv9IqZDFmYtx4O8ZMZqyeJr/PylPXa2ehBv8Vev4JNrYQ
	gZAnh8pOpcpiADktbEEGnyeEKE30LV4POq6214b2E7h7gDddH92cEGs=
X-Google-Smtp-Source: AGHT+IHtHBb93fP3zQEgFqGFlNqMMfooEoozpPEQHkmOFESJJjinzM4IWlZA0S93iZXSwVgBuefZSg==
X-Received: by 2002:a05:6a21:6e4c:b0:1f5:9d5d:bcdd with SMTP id adf61e73a8af0-1fea2d2c774mr2883754637.1.1743028033033;
        Wed, 26 Mar 2025 15:27:13 -0700 (PDT)
Received: from localhost ([2804:30c:1f10:1900:2580:2d5b:b16d:c55b])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a284695dsm11549123a12.44.2025.03.26.15.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 15:27:12 -0700 (PDT)
Date: Wed, 26 Mar 2025 19:28:14 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] docs: iio: add documentation for ad3552r driver
Message-ID: <Z-R_fiDpOqV6yXcd@debian-BULLSEYE-live-builder-AMD64>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
 <20250321-wip-bl-ad3552r-fixes-v1-1-3c1aa249d163@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-1-3c1aa249d163@baylibre.com>

The doc seems to be all about the high-speed setup despite classical SPI support
being mentioned. It would be interesting to see how the regular SPI and hs
ad3552r IIO devices differ from each other (wiring connections, IIO device
interfaces (attributes, debug files, ...), any other relevant peculiarities).
Some comments about that inline.

On 03/21, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add documentation for ad3552r driver, needed to describe the high-speed
> driver debugfs attributes and shows how the user may use them.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
...
> +==============
> +AD3552R driver
> +==============
> +
> +Device driver for Analog Devices Inc. AD35XXR series of DACs. The module name
> +is ``ad3552r``.
> +With the same module name, two different driver variants are available, the
> +``generic spi`` variant, to be used with any classic SPI controllers, and the
> +``hs`` (high speed) variant, for an ADI ``axi-dac`` (IP core) based controller
> +that allows to reach the maximum sample rate supported from the DACs, using the
> +DMA transfer and all the SPI lines available (D/QDSPI)..
Is D/QDSPI about dual and quad SPI? If so, what about saying that more clearly? 

> +The high speed driver variant is intended to be used with the ``adi-axi-dac``
> +backend support enabled, that is enabled by default when the driver is selected.
> +
> +Supported devices
> +=================
> +
> +* `AD3541R <https://www.analog.com/en/products/ad3541r.html>`_
> +* `AD3542R <https://www.analog.com/en/products/ad3542r.html>`_
> +* `AD3551R <https://www.analog.com/en/products/ad3551r.html>`_
> +* `AD3552R <https://www.analog.com/en/products/ad3552r.html>`_
> +
> +Wiring connections
> +------------------
> +
> +::
> +
> +    .-----------------.                .-------.
> +    |                 |--- D/QSPI -----|       |
> +    |   DAC IP CORE   |--- SPI S_CLK --|  DAC  |
> +    |                 |--- SPI CS -----|       |
> +    |                 |--- LDAC -------|       |
> +    |                 |--- RESET ------|       |
> +    |_________________|                |_______|

This only describes how the HDL IP connects to the DAC which is the high speed
use case. Maybe add a diagram for the regular SPI connection wiring or say that
the above is only for the hs setup?
Also, what about adding a link to the HDL documentation page?
https://analogdevicesinc.github.io/hdl/projects/ad35xxr_evb/index.html

> +
> +
> +High speed features
> +===================
> +
> +Device attributes
> +-----------------
This is only describing the debugfs file. What about also listing the usual
IIO device channels and attributes (out_voltageX_raw, out_voltageX_en, ...)?

> +
> +The following table shows the ad35xxr related device debug files, found in the
> +specific device debug folder path ``/sys/kernel/debug/iio/iio:deviceX``.
> +
> ++----------------------+-------------------------------------------------------+
> +| Debugfs device files | Description                                           |
> ++----------------------+-------------------------------------------------------+
> +| data_source          | The used data source,                                 |
> +|                      | as ``iio-buffer`` or ``backend-ramp-generator``.      |
> ++----------------------+-------------------------------------------------------+
> +

