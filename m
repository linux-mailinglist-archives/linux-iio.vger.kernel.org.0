Return-Path: <linux-iio+bounces-24532-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E2BA712F
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DFB175ACC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Sep 2025 13:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE71C5D7D;
	Sun, 28 Sep 2025 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEzQj+cH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663021946AA
	for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067311; cv=none; b=DwcZkY776LwcRXGXfBupUpx6KRBw8BZrPdJYNpBHINvfQSdrGHcCy0kXJmNxCcpnMlmq1fwnqvMUrycyJFdPza4ZC82mBIb1VHjjTWkm6BxJqOmnAyGnLl7GnVzmRre4MvkQnQsHqOvpfTNyzOgAOtJUYbeIPxTmUPUWE6YwitE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067311; c=relaxed/simple;
	bh=FmVHxgqG382cC69d8rXWZwYyOOy1DF+PiCiPPNQ66pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cf23bX0qYzPcoymHph8QFuoP1VjS2oquNLnCY/Iy29p3QbzNyYv26dr+qrlVHEWm0O/eXWHPcmvZv2QY16ubBqYWaqphMygAmfMzApOYQOnxo8c9Ln+H2ToNcY3ze0y//Maa6+4oHwOlyi4qHATT++TC68mz1CPYcmcB38yC8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEzQj+cH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso2663144a12.1
        for <linux-iio@vger.kernel.org>; Sun, 28 Sep 2025 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759067309; x=1759672109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=My/qHt+y2PHKSiLvEMroRzC1fUumz88ynNlnDjtDWgY=;
        b=DEzQj+cHX+g/RZAa0Cy0TWWfpiP+fpqNL5Zd6z/ZvRNSi5CxqFYUwXEANblazCkSif
         AaaN+Gu5dYqpBiPNCDSdBL6TSPpxhErdWFI1sT6RBJRgVv0KSjkalZETzeUIR9zqGaCE
         5cug8wMPN7uiYJe9COvDu3riVPZAUc6Wx4V4HeKwV0R8cgK5HL7K7OqD5fowt8iDZivf
         qExNjZ8zJqg94jccfsBn0rrrC7C7t3Asd1koK8Qe+Zep+KdmSDpQv8Ek2UE3gPGnHTBa
         xCTm/WhMd0R5orGBdCqidE5Jt3f8NI1GuAj9sxkJwVfX52Lcggd9G/NyaGIgL0BOJrNR
         dwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759067309; x=1759672109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=My/qHt+y2PHKSiLvEMroRzC1fUumz88ynNlnDjtDWgY=;
        b=fxOt4iZ4PvbUiXEFGIUkIif2k8If7zAx1CrdAbQCg+AG9gWJ3E8xul/Bljdsy0Nbie
         trsi28gwUyPEUT4MPOQiDRS7e3AtT4cWwkzWEWFqSF72LCP3fMP21Yb+NydxzFXP38Yl
         DdjD05ZYl2WnKK+SNuwtYyoKJtcXz8oIxD2+8uhGvJvcHjWF2+L7C/cOsdmQeSSuiEJW
         iyEkwbOLzZ03+D+xNGg2l4qLYHgWiz0y8j2w/Wxh/UCStj1TTevy72w3LsG22zZ56V3F
         WurkT03wsLwvYJEGS/+RiWr/bC2vNU/+RqsGq//4mmVvGE3ifvbcTH4Q1gLNpNyeoFi5
         Dp+w==
X-Forwarded-Encrypted: i=1; AJvYcCWOPXT/g5M4UoYfQVBT3udZZveJlo2sKLr74z+gbG1AI7ythRBfzbVZurQiEIC+V57AZqeMy83sz+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0RhNlDUdCqUFwTRz5UqACxf6iCwyFC4xsPr0k4GS4Dy55FkK5
	MZOOo8C17pQ2TvnXa7cgKDioWrASXTTy2R+HXFgagfdaRvbdi22POXRN
X-Gm-Gg: ASbGncsUiVYA2SmdDzcA0bVC22TzMD5aux0ZmBjq/j7Rb9BSDO5cimeGSa4VwyWzmqb
	fM4E32fxLMKxggIdarV8hv9C3eSq4BNPOo5jihicvglpvg408E7VwnOCIjHtAxCpuzKh8exEGls
	rsRlZe9mO8bfeaHjAX0YVfSWeMcZ7hc2LjewlpU7u+o/KvxcaSSQJMbwxH8nwHF2npm9poPfE5X
	dUR5PHFghSVgnWESiap/JUu38N8B6EMPKgKLcVTvyLEkTdVsRrH13HCfL3yBS2KuZEGSQeziUg5
	cO3U1i5YACDXMlWWF127JZDVbNAAyB57CFTRFOIa2G21VOaqY+BLUz7TmCFuidWOWd72dTUNVNY
	/O2TN03QoMw96VEOx8OCmHjUXEO1oJT8=
X-Google-Smtp-Source: AGHT+IGXO/qWicj44HJrAinURMObPmlszOlNOo7L+z4Z78O/CaGZYYN86nJQ0OUnlCNPwKAtiNM4Hw==
X-Received: by 2002:a17:902:f9c6:b0:275:2aac:fef8 with SMTP id d9443c01a7336-27ed4a78d81mr101059275ad.38.1759067309482;
        Sun, 28 Sep 2025 06:48:29 -0700 (PDT)
Received: from localhost ([2804:30c:b65:6a00:ceaa:2ed0:e81e:8f51])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27edcbd455asm97105605ad.122.2025.09.28.06.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 06:48:22 -0700 (PDT)
Date: Sun, 28 Sep 2025 10:49:15 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Axel Haslam <ahaslam@baylibre.com>, broonie@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org
Subject: Re: [PATCH v3 1/1] spi: offload: Add offset parameter
Message-ID: <aNk82_gHPDCNDqjV@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1758913065.git.marcelo.schmitt@analog.com>
 <d73804d605d494c6420adb7c0b67f6707628832d.1758913065.git.marcelo.schmitt@analog.com>
 <20250928110052.6fefd6a1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250928110052.6fefd6a1@jic23-huawei>

Hi Jonathan,

Yes, current ad4030 series depends on this.
Though, since this updates the SPI subsystem, I separated it from ad4030 set.
I missed that aspect of the devel process. If we need an immutable branch to
make this split series for ad4030 work, then yes, please, I'd like an 
immutable branch with this patch.

On 09/28, Jonathan Cameron wrote:
> On Fri, 26 Sep 2025 16:01:05 -0300
> Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> 
> > From: Axel Haslam <ahaslam@baylibre.com>
> > 
> > Add an offset parameter that can be passed in the periodic trigger.
> > This is useful for example when ADC drivers implement a separate periodic
> > signal to trigger conversion and need offload to read the result with
> > some delay. While at it, add some documentation to offload periodic trigger
> > parameters.
> > 
> > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> Hi Axel, Marcelo,
> 
> Is there a build time dependency on this for the ad4030 series?
> I'm assuming this will go via Mark's SPI tree, so this is really a question
> of do we need to ask him for an immutable branch or not.
> 
> I don't think there is such a dependency but just wanted to check!
> 
> Jonathan

