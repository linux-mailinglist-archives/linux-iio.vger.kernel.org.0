Return-Path: <linux-iio+bounces-27247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 529CDCD277A
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 207543011A97
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F72EB860;
	Sat, 20 Dec 2025 04:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRJPTpnz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A9C2BEFE4
	for <linux-iio@vger.kernel.org>; Sat, 20 Dec 2025 04:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766205803; cv=none; b=jVhbqI0yMfmwZfYP2ddQlbF1iQxbsyxYVmiED1oqqXStGpeeVpZrf3psM+f1sb0ygO+GmNCFc8MHthsMOsAZ34yhGgh707Yk2N03C3ULgyKanTkZOEN9KiWkJ17BmFBEYlkP/4tO1y2C5o2EQd8xKWkpS073SejOM7O4dFttPxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766205803; c=relaxed/simple;
	bh=z28jYuHS/EG0RA5vNFWBBQuktByn9H+ZzOLC65QnQBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBxGOl5eSYg4NjNn2T5WthFI4pO/ojRd8LUiM6uEL6IV/HlYYmzqYCrJXBhbzOk/hLbDub2ahBihVkmLfWkg6F+UAOoZjC/JcpuGxGZeNAgZUUF/q3AVij2pELJZKohbSLVnqNglPoWsKBfYmrme0xfG/7av/Gin6ddEv6twJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRJPTpnz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so2850758b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 20:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766205802; x=1766810602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9S9pjvKetiM9LIPA+Ep57eTgTaHDSLZV7RfFhO6oLs=;
        b=CRJPTpnzoCveqJ9J5R1p/xAugOmucZrF8nV/qjYv8OOXI91Svkk8eAdhENyvVO/jfB
         EHO/50nwv1dsE2Jxi/ULlUf1hROWmD6EgMWC+1zQeWsO+w+jRckY04nrnJj9gk0vH3dU
         YbmXHEehRWWpIwvqFImsYwk21zNmVnw9hSbKyZNIy+Ii9sAlathJFe60T81JkNdJELa7
         hkzB/iwx8QTy7nw5TxeMoPTa8+d345dzl9B/QFPSsR39vltDbxi90lb5Xmj5BQhzc2ZF
         lOlD60EwXkBuYH7YXNIDi6k6q/nBPH4w2A+Slkzm3MPiKR7GXlfWPfqeUiNHxbNFteSp
         qMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766205802; x=1766810602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9S9pjvKetiM9LIPA+Ep57eTgTaHDSLZV7RfFhO6oLs=;
        b=Pk5V0MNrsqU0ZiDfMsuef6d1D33FU5OML2vUpUGqH5mHWJ8VwKAnrDuUzRkxbs5V3B
         As4TConJNqBsik9m36aBz5N7gYbDQlFg0kbcHjISH4T5qMcUli9/oL+/0SrdmY0s3D5r
         Z7P5P2eNiOsRPf61jlGAwpmQaFFvjhzB4J+zfxpwcQNdSF+nTFOF1b1DPRzy0O0BcB5D
         8sv9ybJL2ep8bi8pZt59slMXhXzvAUGM81d0JwjGi4G7XFHo9QfFvG2khJvtkR2ZWQhJ
         qU20aFFcg0h942AyVZAHhRGGIrIO+cGIgSnYY9q5hb4x/EMK1IH2lA/V2h1bhoSA5sVl
         Fbrw==
X-Forwarded-Encrypted: i=1; AJvYcCXLQhwFmSUWeGiSsCaaSS5/okArJhecBJaOoxqnU+xUhSGOAZXwHP/hceszbyNQVE+JHMQANOrOrf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPUsV6/N8qzRNfuqdSerZAjRE4Y/jTNPcAPZmX9dv4zANSA6X
	MWrCV3wKQrDhS0qnS2UL5XrlJ4/D6LNYI9dT8jXyAyrPNiwqfkomPnxUg2P1vQ==
X-Gm-Gg: AY/fxX49K+rTrCM7OBWqkxnYNex5Ey8UTkise3nYJwK+Jlrcp9ahonHJBj0l0umgQgM
	xxoJkKV56vyYJ7GCjickUHupjgnSCk+jYEGV1o0QfLPi0w31ckFy334QTGPSRb+pXrEWLaUljXm
	3XJjYnbfAKDxl0lwo1FE+ULWsZi0mznijQXSn9MxBHJ46v7ULbN9vMmSixLtp8bSH4iJGXZG/Pi
	seHKgZPK/wBvnqBA6qDOFdVV/vryRNmAyeCENIbWHMMKZf71gJekLhme0NXKAtHc/ekAbnceP8u
	B8WP/oY/Wa6aBRUYWiUr7cDFhKSi3oaQEeRGOghfOFrRTga1IRths5YX4hUxrdcwN39pOw4sL7B
	VPL0MtFs66omGQYwiZ+KYQBXiM/FxEUcZfoALmHgleDlapzztSDboKGQaXxQN3MxIfJWheyLqzi
	Qumm/gToMkwOWYiTuYKiQ=
X-Google-Smtp-Source: AGHT+IHwRgywjwipg+pzuANjgkOqxvpjPpw3HCJi5Wy1gANTZ1+zYv/dSJetZ4wiRm6MmfvFRkIyMg==
X-Received: by 2002:a05:7022:b94:b0:11b:ec5f:1c37 with SMTP id a92af1059eb24-121722b7ad0mr6582267c88.18.1766205801577;
        Fri, 19 Dec 2025 20:43:21 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c058sm15763474c88.11.2025.12.19.20.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 20:43:20 -0800 (PST)
Date: Sat, 20 Dec 2025 01:45:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 02/14] iio: pressure: mprls0025pa: remove redundant mutex
Message-ID: <aUYpzXmxW-osEHPj@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-2-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-mprls_cleanup-v1-2-b36a170f1a5c@subdimension.ro>

On 12/18, Petre Rodan wrote:
> Remove the redundant mutex since both i2c and spi transfer functions
> provide their own locking mechanism.
I don't think that is enough to safely dismiss the mutex lock. There could be
concurrent calls to mpr_read_pressure(). E.g., buffer is enabled and user issues
a single-shot read. To avoid the potential concurrent read (without using the
driver mutex), do iio_device_claim_direct() before calling mpr_read_pressure()
in the IIO_CHAN_INFO_RAW case. 

