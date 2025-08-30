Return-Path: <linux-iio+bounces-23427-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EA9B3C810
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 07:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7671C1C810A6
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 05:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D123AE87;
	Sat, 30 Aug 2025 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtKUo8AZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F125A53363;
	Sat, 30 Aug 2025 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756530108; cv=none; b=jkIq+tMbcly+SUS6ECMqVjaXGHYMk8mmzOCelt69Bs5zmM+Y+Qlff9pLtrTxz465loKT2mFWZx+9unjoiBWdGLDpsAnkzfVlb1TKZRdNuwrhA2NkNkULtJCu2/+RB4g8iQ91Cf8orJewn/9ERDCTWhGwzBLaSXUNM86d0Zg2JAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756530108; c=relaxed/simple;
	bh=m7rzmq9sEmoMah2KJmVzyrVYnCy2Yky9apKj0D9xSSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9Wi1/34i5Zhz5A26mauW3wrDnIXdMzm++ZUuBuSg/mH3an3Q5dEyUYWWovb1IwWSN+RSSFNMVvMsPu7hl/Pn98cV1S8jzMp5hd/kbysFuGCNqwbQI5SIvCVWn4KqMyQiZcwYZ/MxPsCm3vW5ZGyi/jUGogTrCMeZTx+yyMMINk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtKUo8AZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb7ace3baso471158866b.3;
        Fri, 29 Aug 2025 22:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756530105; x=1757134905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m7rzmq9sEmoMah2KJmVzyrVYnCy2Yky9apKj0D9xSSY=;
        b=QtKUo8AZ7Nin4Jqr9VkXt5l46Xy7QWBuRk6hzE2LTh4oA0BLGFr5WH0jzLYQNVy8Je
         bJ7Lh6oHcYMIOcKDDUJ/Y3rEDW1oUHakKunrY1lihH7QVHCunjJgsKIR8gVZO+nwxYfU
         fk9p7byX1ONtir4cC+bjFl9EaowPtbLk7EFEh3iPCQnMXS2vB5kJECy2oC2HWDB5PHrM
         /167XIBSu65EUk5YLA1Me7/RSZcsXJf0P/lfmpcurNiOw1LXxMii335a5LERjZ3yly8B
         T/ntfXd+ZA5KIn97rbPHE3XAi/Ka5CDj/SxpOJjYmkyNxHth4oif5utv40TBOC5o75iq
         F65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756530105; x=1757134905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7rzmq9sEmoMah2KJmVzyrVYnCy2Yky9apKj0D9xSSY=;
        b=VJDeT6nT64UVqGz3GL2GlEMcq8vczL41soR8+qpO9G67obfxEc/FZwleuPM+94vutZ
         KSkkgPGBEOh7XdWupqWaK4nuHOW/dq0kEGfOKFffVRDtJpwcMb0KxniKaenO6L8UB40d
         iuTqOMrx3FtjI23Np7S4sKR3ukX5YPJn3KYWMPtX/58GEHst7H31LK+QGsMr1zGpOL+g
         YzgBtixrKxDkupvMqMpOBEhPNJRKO5J/qwrQGuOY1nZooFsJ5scyN+uyaEpCU7EfTBf4
         uHkblI9QNqAUpIutd41HSPavuZkAcJ0mrBPa27Zc0KXrDVP5oTENWIAVg+u02CPM9dTj
         2omQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGqXF+OAoXlMFNwp34DGsPv0Iniz0ThUVkB5/i7M3eVezSCkMpLqMHV9omqOvsUr+g/0uDRTzh+em6@vger.kernel.org, AJvYcCVciibyFYJuNudtwQx/Se+MmH2zApXmbK/CTvLekaHtq5BRYQCLh9ZRbhSN/IYrVuS+GPpgZ1BiSQLw@vger.kernel.org, AJvYcCXIliOfR5RfoPcyhU91MGLei2zzxwUZGarvkhq0Ipa1w2s3q3cXs5/k/Ju56a30OlgEMbERz+zDmh5ZRNDU@vger.kernel.org, AJvYcCXmCZ7eHtlqQ8/mVttQeskf8Kf4MSPCg3p5oDomaTlEeeO6SFcNyrkMjjtiPc1/4OvOEtZmhFQ/ibYc@vger.kernel.org
X-Gm-Message-State: AOJu0YxLMBL+eNEMNDs4SzFddd6uLi3gKJvjjudByWNSB4PpGqQvJ+x7
	mscixlZ0TetartV+uCkgbV7oWknkJXQy3MWloFR0G8noqucImOZcAkOueUoB4LoEDigfkcDAL4v
	ioYZx71/FHC6IZVPKWkGvsdpEH1UAR0jwvpfx2fg=
X-Gm-Gg: ASbGncsgZDtVvehYA92f2xS38mSNIK28vt/hCcjAOTdAcdqc8nezSc1YQs8/wT6EIUQ
	/0xkqj1LBdCWhqtWDqHymeCl0gH/35zHdf1NZARdpU4QfX4keMSS+W/OD3HtHBvtIw8mgFVIf4X
	nEswYznDdqvIyFC+0uOvDgbLph/0RBC08sz7hHYqk+rfWCBrd3R+TPZunwk79Xb0Lm2MFfnt2/I
	eJ84MI=
X-Google-Smtp-Source: AGHT+IF/4bsd7XA4cuCul7mV2POK8XBLGeJyd9xgivMCEiDcpjuFSq86vuJMUlCzxUuFbjbzLPuj9Ny1UXBvgq4M+iQ=
X-Received: by 2002:a17:907:7e84:b0:ae0:a483:7b29 with SMTP id
 a640c23a62f3a-b01d9793c87mr84777766b.49.1756530105177; Fri, 29 Aug 2025
 22:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756511030.git.marcelo.schmitt@analog.com> <28920aaf9de9438b0c8897b990914fa7724c2e1a.1756511030.git.marcelo.schmitt@analog.com>
In-Reply-To: <28920aaf9de9438b0c8897b990914fa7724c2e1a.1756511030.git.marcelo.schmitt@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 08:01:07 +0300
X-Gm-Features: Ac12FXwnYkzrYOzjwCVXW2bh_cW1_s53x7XT6OnnOrlhvDEtV6QknmGU-5wyrNM
Message-ID: <CAHp75Vccgd=VX4EfyMJvGgTytdxDNP5ZEA1dVGidP4RtGQcsow@mail.gmail.com>
Subject: Re: [PATCH 05/15] spi: offload: types: add offset parameter
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, Axel Haslam <ahaslam@baylibre.com>, jic23@kernel.org, 
	Michael.Hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com, 
	dlechner@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org, 
	Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com, 
	marcelo.schmitt1@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 3:42=E2=80=AFAM Marcelo Schmitt
<marcelo.schmitt@analog.com> wrote:
>
> From: Axel Haslam <ahaslam@baylibre.com>
>
> Add an offset parameter that can be passed in the periodic trigger.
> This is useful for example when adc drivers implement a separate periodic

ADC

> signal to trigger conversion and need offload to read the result with
> some delay.

--=20
With Best Regards,
Andy Shevchenko

