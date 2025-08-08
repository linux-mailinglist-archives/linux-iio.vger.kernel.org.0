Return-Path: <linux-iio+bounces-22469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFCDB1EB18
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 17:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264DD189CBEF
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 15:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27584283FD6;
	Fri,  8 Aug 2025 14:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bceKjS+t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73C283CAA;
	Fri,  8 Aug 2025 14:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754664939; cv=none; b=Zts7mdCNFiW3oHBK3jxHi5gCZ0RKLFEl8SyBc3NFTv8iPOuR+W/iD0hBXX0A2nvLAS2vFCRHkTIBeHWlcP8yK/YMq/umnUKSEfMpSy7502F6SeQ6AqLfnxkxAt+f1hV1YEP3HzPPWmoDMsfseuE6f1mBeuIXxIrKmQdCkhiRLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754664939; c=relaxed/simple;
	bh=v9fbRBg7l5OMVUZ8kZnEyBDxLqNXD3ApiEHqSjjdwPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dYOyz2RYdi/KCldtPu/P26fWoYZ3nOgtGxYliQCfDtZkC009krO9djQLPodn+i9bD9aZ2+++Rx3jnPYMfVhf59JE2U0RABnYEOsuIJjmv9awJH5Vy3WoAVyupuZZf7rYfoHSHKnMYSjzMAkIDPK/X4glzjiuZ/tO1/ACiLcavUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bceKjS+t; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-33243562752so15933141fa.3;
        Fri, 08 Aug 2025 07:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754664936; x=1755269736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9fbRBg7l5OMVUZ8kZnEyBDxLqNXD3ApiEHqSjjdwPE=;
        b=bceKjS+toT9sHUMIz/Rjg/sh6sqYwd+e4tOnp6rkG1SVHCnxcZUX21otVZuq0c8CHW
         G6AUqQuQEmTv0Omy78nb0ncthhgjxa4Hqsyo/+3D6+w9V+uOxI2pmToTICUaiGb1cU67
         PzQsP3lfFPfXs2HoQDrmPr7pJJaLvrr5vqDEmum1g93Ap0nMhXr8aa1sv3I6qFTkhvKv
         fO/isLyy8L4gYgmvHRc6+cghaXh0EUi5+2q7jDscE7ubkLrlKAen/3Y/NY8On0/7EuEo
         BWMXbMsv1tUOfbiiw3HcyePg+j6R2nJrAfPRvkneWdzg510ObdsWOVwCrpTR04kgA+zq
         8HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754664936; x=1755269736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9fbRBg7l5OMVUZ8kZnEyBDxLqNXD3ApiEHqSjjdwPE=;
        b=A11qPAhJLr/eBih3BFGbx7C8a6IL3bM6EtCrt2wqJc8r/nm9rcSAD5W4Lxp0ATBswU
         B3Oh2csnjJZ8Srx1CLxGy4mIG3IEUOW6xsH8NiXvwDbSSDSZblSyFEcc0EKZfaohnTFH
         +t/iPVp3w1fysL/ruapktRBSHRfnw6afGuX5DfF6pQAzyXq0EBuWBnopFV+mIhu8sYfX
         kBvyfTMvwxGBlzg0ysHWyxabO+zWVY5hn09DP1+m1cbiuMPA9tnD0gh//qIYE4F6v3x+
         ADrVfGvDit9AUjQRiuj9bRFr3gybsXr68xG2AOVwKuUHPsVYaSTyUJCFLElx9bDFahxP
         RKvA==
X-Forwarded-Encrypted: i=1; AJvYcCWE+2MMqa9RSSQKUjTzcIsdFXRKy7rU782ZVyYAlu85GXKusZvI5Kd2KS/LssG2MAtTbrXZxUjaEKfjiDQT@vger.kernel.org, AJvYcCWs0GwSmskxOOa0Wu8HNLuzFjte9qpALaCneSdg4ObbPDA4Cf/g1zAKYfFhN5NzlNnRhpMXieE+blA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze83s56GSMQVvH0oBXu1WLqKE/JfuJ1wWuGidrFiTYTqBzKmof
	shtdfv0Di9sRYwK8Jk2KrbESx14xJV+NkcAtfFU6HYBu/pqrmsXwgZDoyDFhxFi669bdFEYqfL+
	koeg1JXpBVa9oyGwuaCmuiDFjDA2W1+o=
X-Gm-Gg: ASbGncubFDrSbnwpzIkd2q/4YxG865uV2sS5hca9wa17umWL52C6jIAGtqSS1m0cyWg
	JNNbPytvZ23v3vSjvUCB23hrItmUR7n1bU5yjeSDR9S0YZfF5Gr454AY/2uKSpliHgt2Q9mHZD3
	+7ouFs+rJT32p6LUamjf3QHU0Yl9t78L5JxT3XnNbZnhJ7NjXhg0+mWHge1hAhUNxVzDa7ZrDWQ
	qSZQ5CM
X-Google-Smtp-Source: AGHT+IGa6YFA3M+slX7DKOnXD7qWxC7HGStALtX/8gPhFl6R1ZKm9wriP0Orf4AV2gpJcQWnwAiOS2xtMri+s1K8SSs=
X-Received: by 2002:a05:651c:4110:b0:32b:9220:8020 with SMTP id
 38308e7fff4ca-333a2268f4amr6707511fa.34.1754664936026; Fri, 08 Aug 2025
 07:55:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
 <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
 <CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
 <CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
 <CAE3SzaTq90n3HP6UrtimxqbmhfkxPNBdby0tY9bxbxzc9pqvqQ@mail.gmail.com> <CAHp75VcqBtSfd9=e2=AYnNhYJgWXUA_GFLFpOjKZDS32jNvCaw@mail.gmail.com>
In-Reply-To: <CAHp75VcqBtSfd9=e2=AYnNhYJgWXUA_GFLFpOjKZDS32jNvCaw@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Fri, 8 Aug 2025 20:25:23 +0530
X-Gm-Features: Ac12FXzwHmG24LVtBf-tOx2c9swGYiPuZRa_QKsRmjyBUP62LXv6Pv61ps0Nceg
Message-ID: <CAE3SzaSF0rQNt7iaz3qOa74tHk+tJyenticOzhrVCBazBPFpUg@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 8:04=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Aug 8, 2025 at 4:24=E2=80=AFPM Akshay Jindal <akshayaj.lkd@gmail.=
com> wrote:
> >
> > On Tue, Aug 5, 2025 at 6:18=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > Are you sure about the remove stage and how it interacts with runtime
> > > PM? Please, check how the device driver core manages PM on the remove
> > > stage.
> > This driver does not even have support for runtime power management.
>
> Exactly. And my point is to enable it instead of playing tricks on ->remo=
ve().
Got it!!

>
> > Pardon me, but I am not able to see how runtime PM came into picture.
> > Am I missing something here?
> >
> > Code walkthrough says the remove call flows from
> > driver_unregister------__device_release_driver--------
> > dev->bus->remove ---- i2c_device_remove-----.remove() callback.
> >
> > Request you to correct me here.
>
> Right, and now find the PM runtime calls there. Put them in the
> picture and you will see my point.
>
Thanks Andy, will do that.

Regards,
Akshay

