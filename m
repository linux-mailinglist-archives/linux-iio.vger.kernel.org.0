Return-Path: <linux-iio+bounces-18844-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B321DAA0EC3
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DCD3A4A07
	for <lists+linux-iio@lfdr.de>; Tue, 29 Apr 2025 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD31DF73C;
	Tue, 29 Apr 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cypq4HsK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA122746A
	for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 14:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745937005; cv=none; b=PUgdoCwPKxGETUXilHunqtMbg9elfBDTSrbYBIBC0wnq28jkmqX3rgKilteFcLbCGlDsiwsJF1R441aAzleZ192n0UmbvUCYqW6u+pqtcb5SVvLNLmZlVP2A0Cx0hjcyFrkluKQrqHTDuujDTbAHo8eN/GXYO2LIZJ/aZQFJ06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745937005; c=relaxed/simple;
	bh=6fIgkeL9eHJItFu2CfZHDJdaT52WI/SYcPf3kHbFbtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDsHFWiG58OgXJ288HkkKjOOJGSUsZ0zpcCWii9go2Q26bngsgXD8PDOX5zp1hDQ++vliLwh6ug/nagIA3UTEzPGKokLvuemhF58HoBuRMa2XP4AFZ5c/Pfbuw6LzHjFu86PYeH/kXMd5e18vEDwLD7PamcrMG/MA4X2KxWRQag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cypq4HsK; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499659e669so7224351e87.3
        for <linux-iio@vger.kernel.org>; Tue, 29 Apr 2025 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745937002; x=1746541802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fIgkeL9eHJItFu2CfZHDJdaT52WI/SYcPf3kHbFbtI=;
        b=Cypq4HsKRcAP5euDrzdA7nsflECY175qjKTvzA9vZV4lXvkcBSGxnXzd6r2VRLeaNS
         uyHv1nz0113/uXr+cM4otwKcbfaWUTx4Ad2FJc7oL8GyDBedtrV3m539BS49TZ7AfN6v
         qu+IdHmdfFJfMdQY1+GmcUKaCvU+fdgG+CNAVRSTcvNWQ0rlMFO9/2nFMePDZDhVVeUD
         7Ng13cHBTk6nyHBB0544Rdcckbs8kV8xpNSLTITW73tcvJZc8PpvAPqbTnNIEtE+hdDj
         FzlQfqnUbeZKT9KNrqexEvAg+uF5YyDTm+0T+guTmedsno4ylc9PpVQO+RRKtstqBzjw
         e2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745937002; x=1746541802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fIgkeL9eHJItFu2CfZHDJdaT52WI/SYcPf3kHbFbtI=;
        b=JU73XOJ8yMA3BGeEP7qfOr/qOV5qpzDC8qimAjmqbtNQL8c8rzrykukD3MaYJcEYjr
         IRQip3Nq/8EG+VFITeSL2tIEali//BnMj0r+gXmhT3CDvaX5r2krBvlV8BC4OuakAh7u
         E3seRVnCs6QwXLj7eBL93DX+IY/VYHfMfrNnMHjQenBwsWFFZb27ZFWpyKDvnE/fXVmk
         6jpv7ECxupuOK4fHeJenyhlCG0AdNPhIY/y3r7Oj0DcmaInLzvMqn3/u8WZmE1t2jQ1V
         dngEUuWCQvSzKLCF1u9pr1dFovcq5wVbXuoa2XUUpNtWD9gEVMhFfaZ2Fu2pTNPlPSRw
         +0bA==
X-Forwarded-Encrypted: i=1; AJvYcCVCMlnT0Y9q0gCfQCdpg7j5xVdU1Or8dR5YmNpImu3kq4Jp27cMZrGej2Ooubz9a5wXKBbiX8ziW8U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7rG31EQuD2+9zDRnvcMIRtR8BX7sm1gsnbl1BQbFbl+mo3NN8
	8poq0bJCMNQagJVuAgMWoNQz/bTlhT5gMAlvwXcBB8S3Pr2vAmz3LQ5MRaHd/F9/2fHQgngt6xG
	RFF63y/lxoDxOXH3JlpRfgs+fYfI=
X-Gm-Gg: ASbGncuxAPkvKVoX1SwPetZ0oyiup+isiH8MzZ9ZUC1lXS6o/RDIm8Ig+K2c/88Z9o1
	JGIONILZkdvqw/m+NKsCRgAIM3HkOwo9F8Tk8xzWlqFRQHzjIe50YnUOpflkt0IDnlCS+lpPQUC
	kFJwRtTlakPVSY5KkQoVxICxWb0Q+cRVlQq6sEuOk5s5N1LnMUaiCXVA==
X-Google-Smtp-Source: AGHT+IFaMEau/3tMlm3/erOISqZudRhA91RTwzJg5kYJA9U7b+dx9moVAOq0c6MV+Ssy4eeriLTGi4DowTGYGF4vrig=
X-Received: by 2002:a05:6512:3b0d:b0:54d:6a89:8448 with SMTP id
 2adb3069b0e04-54e9e53acb3mr956546e87.10.1745937001582; Tue, 29 Apr 2025
 07:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
 <20250426160009.161b9f08@jic23-huawei> <CAOMZO5CepxxXo9u+mSB1P8t-tKvayz8b39emo3jHzR+6hr1HSg@mail.gmail.com>
 <20250427112343.207918cd@jic23-huawei> <CAOMZO5BOXGcuuf7cyf-c6QLXVoKber2oWP+sgWA_RMHQtW5-cw@mail.gmail.com>
 <CAOMZO5Bzrfu14-mzaF+EbAq=xGKMc-FGwJsx-aZd_RraH2Gscw@mail.gmail.com> <ef215ea2-e283-4c89-9b54-61b84684bfe7@gmail.com>
In-Reply-To: <ef215ea2-e283-4c89-9b54-61b84684bfe7@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Apr 2025 11:29:50 -0300
X-Gm-Features: ATxdqUEyxmZ6OrMTADW8Lv2i532gZLYh2XPc89pdS9MZnXgoo0ABQCEw3QdPb6g
Message-ID: <CAOMZO5C2VKbu3pd-8jGLez=ofhjDHZn1onB1vr=XL=5xW5jtHw@mail.gmail.com>
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matti,

On Tue, Apr 29, 2025 at 12:59=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> Do you think you could send a patch to fix this, or should I take a look
> at it?

Yes, I think I understand the problem better now and will send the patches.

Thanks for your help.

