Return-Path: <linux-iio+bounces-19905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8135EAC353A
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 16:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49BF916EC7C
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1BE1F3B96;
	Sun, 25 May 2025 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZLOkBL8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27CE2DCC06;
	Sun, 25 May 2025 14:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748184890; cv=none; b=MRcboJ5YM9ca3/hr9C4eFK/llZpsELVKBqEus1KwluNATogrip+isxnnAJslZaxBXGVq6WAx8NCdmRw03VMieeSk8tb7EzJ5filS/QTkRDjeJwlsLFH/hjyWBNjj/VELVFHDnf8GzEdw2Ep+mlgOoRJwsAzC3uiW2l79lCHZ9cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748184890; c=relaxed/simple;
	bh=pIRSrsJ+0PAW784/KcxOtL2TCfpe6hf0uxIN1adyYhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VjBcklc5KbiM55owhTyVSBq3mCk17apIu/MWan4Rf0fn5hEd12aiZLQ9XsGWdz3RDm2QOodbXBN1zX+6x8CmFXZmw52g0RRUJY04LQStE/ATeLRSrEyU+003dEUf1X2AHZvy/Ie9ZNouR2gciDowtVGZO7sy3Gm9Qh0/3snXMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZLOkBL8; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7d8e2a80easo157333276.1;
        Sun, 25 May 2025 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748184888; x=1748789688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAG6mpPVVqHTtCkf54r6bHKI27v4kN8Mi19Lg9+YxQg=;
        b=ZZLOkBL8ul125iWUs9eG741ye9TWqg6UmtuYMW4OOlL/FqtLKUra4ShHNfvKF2zjVh
         5OLZxNrKJ0eAPbMsSnWNyF/JfcUz5SMpOrIwMaw2/i05QFOoehkE9e04NrBAD1MUZUJO
         tp2MpWBf0d100kr5KsAn5hGoMOnETcY24J7TYPKrG+HM23CliymoqC2yFa6xAKnL+ACV
         eU/wCkxcVkpbJlD2k1GHQxAySCl+ob4zKjPpeAVELtk3pEMQDQ3ddgKpnZE8zmK/1Db0
         9pguAB8iCKDMIxxuKPe0JrJu6w09lt7hIWlrmSuAggkQQwlh96B1P9AmX9X1sqErdCF6
         Qb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748184888; x=1748789688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAG6mpPVVqHTtCkf54r6bHKI27v4kN8Mi19Lg9+YxQg=;
        b=ZfvfZvTADIZhRalHUCPde3aPEo8sJ5FsTgtDgFKjt9OD+ybETOXmbs66ZIiN46ix3R
         YDl9MKPhBN9mQVZBGUY8m8VJMI6nDHudbXvdPx9B8RV7rFwCOmbZC4+3cCq+SQVRt/fI
         FQDdOvZuGgbe9XInnOdtTLD5HgQ6gPqkRaIPHQmPIwk2voeDo/wa8TzfhKlT9ing4KNP
         mJswhpmfUZySzQjbPRnT+J1Un08sBG3hs5DpjtUlKGL6zmO/i8LJkr62QFa0xVfAxIQD
         qrsImAIuZsk2Gu7jic8uu7RzGi+gb57I4bSKbEheXjetLI8+N8CUGbHiwsSlrY6HM7XC
         hUAA==
X-Forwarded-Encrypted: i=1; AJvYcCUk69iE8zghcoPezX7yJD2mF1OxkmV23lZSuEJERuX1/LlTp0Ib/Wl3n1HKVh6M52Uy6mUrvLGQbwoz@vger.kernel.org, AJvYcCVmsNR8yhY7UPOsJiDaUSqqSGCzt2OqC/uLHM89jAOxdeHq205zjM6y5h01Hnffc9nFjXZSLS3rEMk=@vger.kernel.org, AJvYcCW2Nq1MDvOEFMnkh/tGP83x7yBygFO7L5/K5PloxCRynL7eatCojOouyzc6ySS3VRDhlK8OLu3g4bxFOltw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KoU4oJFy8e2CmGJsh1DhrnK6Ori6m5vxe+KvL5wQnqyl7Yra
	wbLDJHmxA2v3laBncaL2qP0Fl1OVBq1cZooSwPo1DZOXIrP3YHqpSbnOH0nteZn4/YSKVL8mrXi
	a3dB+MrwChvVLFMZszwYh8soXRXkJ1rs=
X-Gm-Gg: ASbGncs8T0GaGlQ9kvoxbvUwFfGwIwcm9lFl1ItfK0gCnxqDdFPxxK8XciWG9To5XSo
	UuAOzCnlBgfNNtPjMK5bYhG/XSMombTYgMYeEmcVOeYDpSufQgNSyucxEH0jGVIwUu1H3uWt4wB
	7xbxFtwEx7xQBtXRdY8Yveia7W0AOzNuvWERobtOudoVk=
X-Google-Smtp-Source: AGHT+IGLaqdTa7Ehw7BKN+X9FJqrTXShWEjfvkWtMtBfO/35rVFX3kgsbUiL6IEmpuACXgsPQwMOWSTp5ylw8It0GKM=
X-Received: by 2002:a05:690c:6c89:b0:70e:4cdc:6e7a with SMTP id
 00721157ae682-70e4cdc6f0cmr7420437b3.6.1748184887595; Sun, 25 May 2025
 07:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523223523.35218-1-l.rubusch@gmail.com> <20250525134958.19fec8c6@jic23-huawei>
In-Reply-To: <20250525134958.19fec8c6@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 25 May 2025 16:54:11 +0200
X-Gm-Features: AX0GCFudRNyUfqgM9VgM6E5UXsQ_glgqv-zYO1su7Ey9rqvDUjz_kbtg2LTLeFI
Message-ID: <CAFXKEHbksqY9Xn-0SCHbUmU-YOR2y0TqDXZFtc-ARA+gXNd4Xg@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] iio: accel: adxl313: add power-save on activity/inactivity
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 2:50=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Fri, 23 May 2025 22:35:11 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > The patch set covers the following topics:
> > - add debug register and regmap cache
> > - prepare iio channel scan_type and scan_index
> > - prepare interrupt handling
> > - implement fifo with watermark
> > - add activity/inactivity together with auto-sleep with link bit
> > - documentation
> >
> > Since activity and inactivity here are implemented covering all axis, I
> > assumed x&y&z. Thus the driver uses a fake channel for activity/inactiv=
iy.
>
> Hi Lothar,
>
> I think on this occasion you were a bit too speedy in sending out a new
> version.  Might have been better to wait at least 1-2 weeks at this point
> in the cycle, or until you had a few more reviews in at least.
>
> I don't mind that much, but it does create noise on the list and tends
> to reduce the focus patch sets get a little.
>

Hi Jonathan & ML, thank you for this hint.

I assumed Andy was just "taking over" here. In consequence the rounds
were based on his reviews. For the future, I better await your (any
IIO maintainers') reviews, until going into next round?
I accept how you like to work on this. Nevertheless, isn't it more
efficient when I resubmit right after Andy's review (if I can), then
you review and I re-submit again? In this case I would go through my
codes thoroughly twice, which usually improves quality of the result,
IMHO. Since only the most recent version of my patches should actually
be considered, the older ones could simply be ignored (not sure if it
is possible to flag this somenow from your maintainer side). I can see
the point, though, where this increases the number of mails on the
list. Nvm, just an idea. I'll wait in future.

ADXL313: I neither care much about the number of rounds, nor about the
split of patches. Thus I split rather a bit too much and you tell me
how I shall merge (I think that's easier than sending you in a big
blob patch and figuring out then what and how to separate). Pls, let
me know if you oppose to this approach?

BTW, I also still had a more recent version of the ADXL345 series,
containing the freefall and inactivity story. Current
question/proposal: Freefall and inactivity, send out the same MAG
event. An Idea could be, that userland software simply has logic to
distinguish on timing, but the kernelspace driver here is doing just
the same IIO event.

Long story short - I shifted freefall to the end (also in oder to
easily rather exclude it from that series). I expect this NOT to be
the final round. First, there is the freefall situation (actually I
expect objections from your side. If so, I'll exclude freefall from
here). Second, by some of Andys reviews I feel I also should improve
the ADXL345 a bit. I learned about regmap_assign_bits() which comes in
very handy. So, if you tell me the freefall approach in ADXL345 is
nonsense, I'll exclude it from this series.

Best,
L


> Jonathan

