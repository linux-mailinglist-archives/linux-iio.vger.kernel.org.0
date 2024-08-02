Return-Path: <linux-iio+bounces-8176-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF497946641
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 01:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15041C211D4
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 23:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF213A879;
	Fri,  2 Aug 2024 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mechatrax.com header.i=@mechatrax.com header.b="ZzbPyame"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04B1ABEB5
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 23:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722642710; cv=none; b=SmQYGQ6j6AyZ6lLxuXiKYNbu+RUIuWb62AV/vvVTtJcmJB40jhONOyPiyz1cUTJnMGcdNldlrfDrq1uTvsEAaJnGnw4o4XJydxKrsJ84pjIgCrOO7oiwG+ebZoTOTFrl4pAcT3sZCQYuRS5qy+MZilAg7xktMQ4qpNIGJEvrY80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722642710; c=relaxed/simple;
	bh=EuAtzJlOeHEnqCWMfQsVY8CejlxikMRQhNBuLg0wVi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOVw1H0rpoPs6CBM0vd7CoRkF9sGnar2HueQzmIYHLDz2pSc9y8d+ZndbdNq+qvIoYNjt5kEdFMmxaPhpT0abTpESA8+ymRFKtgVZz5liAvX68kaZ5E8CXm/pH1vPgcXgT5FASdpKmDoOlJry6FGht5uBR/Umd1IJ8e6fFwk8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mechatrax.com; spf=pass smtp.mailfrom=mechatrax.com; dkim=pass (2048-bit key) header.d=mechatrax.com header.i=@mechatrax.com header.b=ZzbPyame; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mechatrax.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mechatrax.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1dea79e1aso493179185a.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Aug 2024 16:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mechatrax.com; s=google; t=1722642705; x=1723247505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EuAtzJlOeHEnqCWMfQsVY8CejlxikMRQhNBuLg0wVi0=;
        b=ZzbPyamexMd7GgnkM2h48IQoBw3slZ/rLZDxQfTKE2piugSwFnpwTtXJ4nM63IeRw0
         XoRe+ac4fdfKa32b4N37fFuWCnWzlw9HXl/9AJ5pNV61W8nbDH939Re+Wtvd890k0gnd
         w7MMvBmz16GPzC0O5iByPhRNtn+zY/cqbQqE8XoT0Z8b/kLcWhJvwekqkt+M0fRkq3a+
         URKo/HF7eH8aVSH0qMTIY6nveDnZXeKqd1Etv5kytWUnSJ5r2lGN3He8txAn1f4swLAK
         MD7S5fkUeSXF/jV3vLrprRuRSTNFptxPJ4lP+gnFsZJx95L3ObwVi7q/Z8FbHg9EB3nn
         2emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722642705; x=1723247505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuAtzJlOeHEnqCWMfQsVY8CejlxikMRQhNBuLg0wVi0=;
        b=hAba3+pjYBtJeZmlkbALCgX8cqa+Ytv0NvoQn89hQutuDj1Zm9IjG8JFV5JveDloWI
         VB4Xraub6MAY76NCDGS7nKjizbS/RT9Djc4oCgDJYju28q1/kFUHfqLAIDJUegUsT9Vx
         QQS1057+lOASEkvo1v9w5jVPCFnPxU9KkJvj1hr32HZd8a3kVZt2SfjAJhp+RaxukKEH
         KSX1EVFB0f084vkSHSiUkDTmCrIEAqmcg+oYBaJLxjP97D/PewWGDWcMziWXM0pihFpK
         /x4HNo5Fw5tcxjWfWTYJB0b5zWTi4jDV7frVAi6jk8mu8IT2CAi2ux8VbqFMJn9C5PK6
         2paA==
X-Gm-Message-State: AOJu0YxazJUq1L8RtUEU5a1fWTwUYI2mZCBaqOU9YjvFMeiE5BPp8Nx5
	0++VPwfL2Qccm/cI0536fPjtHCB/1mA38nZ7Wa64pOzzElhIzipns4vxp4VpDSDo33Q3G4387tG
	d09u8jLmckbpdnZZqY1opMnfEyZT27F2c1MRbvg==
X-Google-Smtp-Source: AGHT+IEpCjMfyPcEAF28AiaFrKfRbBsOsdUZ5GJhwY6BVOynlfc0KT5bXrvhcRkPeMp4uoB8nR2vh6DNmpRy20Qsz9M=
X-Received: by 2002:a05:620a:46a6:b0:7a1:e0dc:ef99 with SMTP id
 af79cd13be357-7a34eedf204mr623818485a.15.1722642705404; Fri, 02 Aug 2024
 16:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DBBPR04MB79150A4614B6957A759EC31EFEB02@DBBPR04MB7915.eurprd04.prod.outlook.com>
 <DBBPR04MB7915EA1E74A0313181A66E0CFEB02@DBBPR04MB7915.eurprd04.prod.outlook.com>
In-Reply-To: <DBBPR04MB7915EA1E74A0313181A66E0CFEB02@DBBPR04MB7915.eurprd04.prod.outlook.com>
From: Masahiro Honda <honda@mechatrax.com>
Date: Sat, 3 Aug 2024 08:51:09 +0900
Message-ID: <CA+Tz-SF-1j_pt1uKOFjfrC7HTFXv3nmx=BQpfKtadtbWtvDXzw@mail.gmail.com>
Subject: Re: iio: adc: ad_sigma_delta: IRQ issue in conjunction with IMX gpio hardware
To: Arnout Diels <Arnout.Diels@dekimo.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnout,

On Wed, Jul 31, 2024 at 12:17=E2=80=AFAM Arnout Diels <Arnout.Diels@dekimo.=
com> wrote:
> What I find strange is that that seemingly the same issue is supposedly r=
eported to be fixed last year (https://github.com/torvalds/linux/commit/626=
d312028bec44209d0ecd5beaa9b1aa8945f7d).
> However, the "fix" here was to disable lazy IRQ. This does not fix anythi=
ng when using the IMX8 gpiochip, since this will just mask the HW upfront, =
rather than waiting another IRQ cycle first.

I am using bcm2711 and ad7794.
This patch works fine for me.
However, I have not tested it on other platforms.
In addition, I did not fully understand the behavior of IRQ on the gpiochip=
.

Thanks,
Masahiro

