Return-Path: <linux-iio+bounces-18517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554ECA97257
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055CB4041C3
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A40290BCE;
	Tue, 22 Apr 2025 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEa9QoD1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F1290BB5;
	Tue, 22 Apr 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745338572; cv=none; b=sHciHsfkG9v7Bmk19uuAqqXzNmUP9wpyMQ0pFQVEIlVUYO8Kgo53UhPhpUrAxICZOxa+T0Ojiu7gmdXtQjDJEsViajrHEB4jp9U3OXE3/JiFRdj5dzt9L7X4gWMJc5ZIjOiz0EejyCAWgSXp0SX2fDcFJdZHYVAlhqMYNbZPb5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745338572; c=relaxed/simple;
	bh=AopIbP35eGEgwicypHA8bN0HUp8CeM1DV5674wfHfxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRfZSLMtHmP6s3+ODAjnpCS2MMGUx7NYt2SXPHm1VpCQXbG7wJJOLMjDq1pDrOzL58PXiCtJLZ79OKcgcB5xVYRMSrv20yiEnmcfEyT1yMnC5Aac+nmLZe56CI1E6XH0cAnoyDonjExm3n7kJ6sz5TtT3ccgkxq28Lhe3M/gWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEa9QoD1; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476a304a8edso56180331cf.3;
        Tue, 22 Apr 2025 09:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745338570; x=1745943370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFrBh3nLbpLrS3oZ1YSe8c9ey0iYWQVPOn6Mdnaex9Q=;
        b=QEa9QoD1lWhPjLNEqUWysYOPa5bdYifcY0/c30+x6C2cmQkHV72GxVfGYBJ5dg+vNc
         z2jNN5Jqxhdf6P4Lob1iguv4Ps+k3QVlzMdzyBUpNfpsOd0AzhcZfcbocCjjnyDL8v9n
         SuvCtqnpdZw2lzLA9D5tVGzsumIBLGLHC4qgn5LlQ3eaP3X6j8Q+6rpOyEKVSW63P1lM
         graOTGgy7xbylcP2l2+kt7bWU/wzHS5FYrF9RJokgov+XP2uYHp4ZoZ7Sk0CHhquCLyY
         DL0nbSuoJg3wUtfv1FeWSWyJNPqyRk1k3Mw3oU/S+JPZPz132Rplg5bNs6EXkdfE46QU
         z9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745338570; x=1745943370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFrBh3nLbpLrS3oZ1YSe8c9ey0iYWQVPOn6Mdnaex9Q=;
        b=CC7MT5qoabihZTS2vOwUeWaUi5ntjpIpgtprcjBrXN44YTn/3ez0vrUkvrbK8Lk5wS
         0RPe7rVeDp1aH9iwPF441e/d0S4TqXPHn4oogwjKczbxMOfK/CjLTbdsj27nJX9f2sHY
         xoBIBVRmJb4X7FH5OKO45I2ppn0UmHUD7IZ/m4nIjSzyiNA6LDdkTzBxHbfk6Uuqxplq
         ZKIaqB84oj+86CpiuGT183xsmpktqC/55UO12x2MfGMkCpKtq4H7B0R6fGskR2b8YEeN
         /3JCG82sS1x3HKhitCXgMYb18D/3kVH5gyCMeyMNlv/RMYsFiIwmEMp5ILUyVjhPN7wQ
         5eRg==
X-Forwarded-Encrypted: i=1; AJvYcCU77D4xmQW4SMTnRkUGdPLnDiqXDCVQmF4CwTWeEoOB+rjpRzw6yxcIBx5yxl1EPYxEurciKmQKw2Y=@vger.kernel.org, AJvYcCWf2KO8jvT1Vb8FftkzoUqW0ZQXeDXM+ICXP4ztKWzpfSBz0Q59p4T1/VP9taoQpDFFtEa8fKV8yfMKxsys@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCpfjJpncUdK2mgDt3EFblsHaZa3oclJ05XY4mh5bDsAPz8xD
	A/R4PPOUZd0XKKhCQfZ7koJ+AA5T2ts03cURqHhH4m2go9K68nsE0Qjkcbg78ETfIW+Oyo/q4cR
	JqwZ2sqAt2BheEkiBtDWKGUwc9T0=
X-Gm-Gg: ASbGncuJ1+pDj/lwPK4pxQfXYaDuMJwHxaYPAPYwMpagi2BYwOvCfnkxcOTYrSqO1VX
	COY+zpg5fnJTLZ9NWukomWdlRgx7xOtm7cwDAZKpfgPl3v2FxMaTSSyAF9Nj7sKizhyHqQsybbh
	j6IB6CDBDcpdTziWCRE3MqQLu0W1Sxa2mx+PpvowTefkqz0mSPEhywNg==
X-Google-Smtp-Source: AGHT+IEIZQux+2VZKZBiPdCzgiFdjJWt6dz9/yhL5Bl8TAYiGGo+j4WrDdwYDO8XMzu/v1izVhNnYybHv2SPXUyoYH8=
X-Received: by 2002:a05:622a:40f:b0:47a:e6fa:9127 with SMTP id
 d75a77b69052e-47aec3e2a70mr226351681cf.23.1745338569997; Tue, 22 Apr 2025
 09:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420175419.889544-1-gshahrouzi@gmail.com> <72fd8919-8413-45f4-94fe-277719192536@stanley.mountain>
In-Reply-To: <72fd8919-8413-45f4-94fe-277719192536@stanley.mountain>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Tue, 22 Apr 2025 12:15:58 -0400
X-Gm-Features: ATxdqUGx_cgIWLZbKoGp4ssu-0SjrT6ROY7nG2s39_luaQeuquqvHOmIbiJ4zas
Message-ID: <CAKUZ0zJLAvi_zerjB_xmtjJs1TzLxY9-grLRGxZHN8n5qtDR3A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix and refactor output disable logic
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 6:09=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Sun, Apr 20, 2025 at 01:54:16PM -0400, Gabriel Shahrouzi wrote:
> > Patch 1 includes the initial fix.
> >
> > Patch 2 refactors the code to use the out_altvoltage_powerdown ABI.
> >
> > Patch 3 adds small improvements by minimizing the size of types and
> > doing a redundancy check.
> >
> > Not sure whether to include a read function for powerdown as well since
> > all the other attributes only had write permissions. I can also do this
> > for the other attributes to help modernize the driver.
> >
> > Changes in v3:
> >       - Include version log in cover letter.
>
> Please don't resend patches the same day.  Give us a chance to review
> it otherwise it gets split across multiple threads.
Noted, thanks.
>
> regards,
> dan carpenter
>

