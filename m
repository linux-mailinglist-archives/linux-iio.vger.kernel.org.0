Return-Path: <linux-iio+bounces-12755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810D79DAF16
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 22:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088FBB21EE4
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 21:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5054203711;
	Wed, 27 Nov 2024 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1H8+L23"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F24F9DD;
	Wed, 27 Nov 2024 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732744142; cv=none; b=J5gYKS1Zvos+d7bV0i2lo9obaQsKZ6gFJUKq5HDRe/XVGLAW0JdkUvNc2vTOT/HTq80mGaKlRIjm6Wi94wVUAlmOCzs2RvstfmpHVZ66H1NEaxhDsza/aMt2IyJSao3yyT0XT7jDS1rt1Lv7GVi5/hur2ewKF6m6lQFDTe4DqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732744142; c=relaxed/simple;
	bh=YoegXgtOPyiidhiPyWL8AKBM2sMEFRiGoSx0kL4ESXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YofAFrBjjdL2tUr4NqsSetI+vV+OqdlH/Ha2rB4JLLK7Ow6mkxoJ1nWeexO61nm53RfrgZX1SQ4/RDIJez2irzVzVPauDA9/BHrlsBdx5gw78uozKgXmzRKMnDf4RmIgO0ErZK4AMfwlTv/Gk2fbnZDlGmyLGHN2E70sG2x6Czc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1H8+L23; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7251331e756so224821b3a.3;
        Wed, 27 Nov 2024 13:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732744140; x=1733348940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoegXgtOPyiidhiPyWL8AKBM2sMEFRiGoSx0kL4ESXE=;
        b=g1H8+L23Wzj5Lcst0w6YEEvuyZZKIuVjTVIztC98ewJmFCcWIN0Hu+eD5Sxq8vZKKM
         ihsuRn83hB305ZkLnBT5nCKAmycexqCkibQJ6FjT4dgAAMGeyfINpedjndmyg3nQ1RGA
         pLnGLdU7D3m9DlZMlTa9x41OhuWqmiwUO8SrFhgJIEsGQgaMaeFYhPhpSGdfIH6NprM6
         SjIXuC+ilRv3K1UMBhEmBkCztxIS/POCOs+26QMqUJdH9EEnXP9ECQCEWuFVWaQ4ULsq
         wAdPbxlGIlaODy7p6QqF3tuaBxVReWb6ZFoKmSCc8TY/YS/xjl/ICuGCTNcCeWN+HCpn
         rxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732744140; x=1733348940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoegXgtOPyiidhiPyWL8AKBM2sMEFRiGoSx0kL4ESXE=;
        b=I4+2s9FZbdvdM5hj12GtQZPcnUl7hN43Zds56KqmtU9bC/TS7/1j9pJmp6eP9l0isV
         3cD9f3x4w9JglolAAJIJS3UesYZpChRMQ6FXjMLT5FnB3xX/+BN+b2NOVh2/5DECHYld
         KPpmxlSXgMRM2qrQcGkg259FVTZLqi3uQ0UdgfkhhHNNFi5opU3euzRmdAxL2o15gbFv
         q3K3z0mQzc4fXj4CumgytO8TVqWMZvzY7NoqFvaCO0fo9+tgeTjGA88KF0O7AOfORG62
         dyJVI5kx3s48MJF48h0LI8M/3yRxpG1RtgrA5kRhd35QkCGbIy+U7wSoTHPq3ggIOwC8
         hE3w==
X-Forwarded-Encrypted: i=1; AJvYcCVh0AdXI3+IUjoP5bQIfgqLROtj7/eNdSY3PCI2fslNExhXvkxhWUPXBg3f7pzWkcNLKo4Mt0+uovJCd4Ph@vger.kernel.org, AJvYcCW4QX5LMmY7PG96BqTT27bAcNFJnuzuXenszITzd/MF2xOdKRZ56KDceOZlJq3IPx5/P6Y/AQJUu5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGw2zeIf1RG21Y5/Wx+WA8W5cTdWzFdstDF5Cn3jjvBlwQjhEP
	9uxDQPRkQBzC2TZ2KRNRpCQogdcIneW40yWL4gKF3BO6P9SaVoYmmALQvwT5
X-Gm-Gg: ASbGnctlMNnq2TXuKGblTvLTZEP0+pLCOAaLx9BpEgPLV5Pj2/WkakY8XF6H0KijzP8
	61DNApvPeHWGDU7dzvNpN7S8axks5HD5vyEU4CMYSQ3RI3SIh43lvmZ5KC4zV8A5g1ckZm3wng5
	cfDqWsvR8HTwzO8vaiuIseyM6MJ3JDvdwT60zNyXayAyYOkj2PZXHGNtrXnU/CZ58qMnXWbvqsL
	l67vQTWWOb1pZSmFRhiwZCnw97547ns3J+D9kZn6lJ9SOhdttBtRaqqpQsVZUINPIlwtmE=
X-Google-Smtp-Source: AGHT+IGyUmzO44BsU8q/Aa6Hva5Dgo/rfWjdaX6jmLkZde8IjTEO44IahiSrl64S/iPOsAlmJtRGlA==
X-Received: by 2002:a05:6a00:4654:b0:724:d503:87a1 with SMTP id d2e1a72fcca58-72530045ca1mr5987101b3a.7.1732744140488;
        Wed, 27 Nov 2024 13:49:00 -0800 (PST)
Received: from localhost.localdomain ([177.10.10.137])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725417fbae3sm34998b3a.102.2024.11.27.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 13:49:00 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: wbg@kernel.org
Cc: david@lechnology.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: Re: [PATCH] Add COUNTER_FUNCTION_DISABLE to the counter API
Date: Wed, 27 Nov 2024 18:48:34 -0300
Message-Id: <20241127214834.1709-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <Z0eAg9HRlYlCy25H@ishi>
References: <Z0eAg9HRlYlCy25H@ishi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 05:26 PM, William Breathitt Gray wrote:=0D
> Hello Rafael,=0D
>=0D
> I wonder whether a new enum option is actually needed in this case.=0D
> Wouldn't the Count "enable" extension already provide a way for users to=
=0D
> stop the counting? I imagine the driver would determine implicitly that=0D
> the device can enter a power-saving state in that scenario when counting=
=0D
> has been disabled by the user.=0D
>=0D
> William Breathitt Gray=0D
=0D
Hello, William!=0D
=0D
Thanks a lot for the feedback! You raised an important point.=0D
=0D
I would like to explain my reasoning behind the implementation =0D
so you can see if it makes sense or if I misunderstood. Basically, =0D
Texas drivers are described as user-operated through the sysfs file =0D
system, echoing some directories in /dev/.=0D
=0D
The requirement of my application was to communicate at the kernel =0D
space level with another driver, and to do so, I retrieved the pdev =0D
with platform_get_drvdata(), which was allocated with platform_set_drvdata =
=0D
in the texas driver probe. To apply the required settings, I used the pdev =
=0D
I retrieved pointing to the fops, such as ti_eqep_function_write(). I made =
=0D
this small change in the module for this enum value and a patch in the ti =
=0D
eqep driver to handle this in order to establish a safe shutdown.=0D
=0D
In my application it worked perfectly, and so I had the idea of applying =0D
a patch to kernel.org to see if my changes could contribute something to =0D
the Texas driver infrastructure.=0D
=0D
Best regards=

