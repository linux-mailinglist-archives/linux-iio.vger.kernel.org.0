Return-Path: <linux-iio+bounces-701-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1C8083BC
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 10:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAF11C21F18
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D0C328A6;
	Thu,  7 Dec 2023 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4tT+fWU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E8810B
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 01:02:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c19f5f822so3684045e9.1
        for <linux-iio@vger.kernel.org>; Thu, 07 Dec 2023 01:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701939777; x=1702544577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxWExaqYjPbqEmFO7/xmhzrULdmiyTjmnLctPKTLp34=;
        b=O4tT+fWUoqIOhRx03hkZI2J4G2rnyAzmJEM0mRumXSQ98NIZnk9uJL8FfFE1HVueD2
         FrWB0nSXnDqIrSOkyZdzxURjh+urmB10FmR1KJ8p2enknJ2v/jTCUGLEpGfoE+nJtfNM
         0AdZ4SN1KzKwisFeRsmYbLLFoJmRloUbrwdcLrPg3tVpsxXaqahaIBrgXYBrcRHg5ZE5
         BW1iAVDxT+xvWRLeSqxGrV65G4ya+DhVs6vAVtLAYE9MDXrfvmq73ofkCZxnzjSFSgcU
         0eFRIiuI4QcgIIFtZT3Jwu7d3frF1I3KCPl51wHeAJCD1u/M8EDw6jDD4WxADuvmOXjf
         EASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701939777; x=1702544577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxWExaqYjPbqEmFO7/xmhzrULdmiyTjmnLctPKTLp34=;
        b=KuLdn4db0gEf4iB/fSfjOeFS0wQ2RcUXEwyduHpOJI5avZ6hBBa2yLckdWmLqxfbpP
         xQdDZWuS6pVsmo7Bookg5JtWb4Hu1JX3B1ylBGvhKdyJEZM9Gi0TIdGGCpnNqjDJrSG9
         NET3eCfrBT5Uf4MPzZIbKKCT1oGROwU8qtevthwkmUZdXEl3PMMvTsCs2V0CKHe6o+xe
         RFdH/fVZQ5hiJrSMYc7f/Yu5U4dC4GpdpupsbpOVZ+UrvaFmoCg1uGk4GxRBxXtaNZnL
         lQcbYSDChnhWtCVk6wHl6gLTLa1/OCYwPBtSgQ5wrduWuZwXF5Z+6wJcNob3N7RejPYV
         429A==
X-Gm-Message-State: AOJu0Yz/WYwmuyoEFJXugB7jdDUTUM8ng7AMMu0I7FQJvn7+LfOINGgy
	CPHjHKExUyPrcZINSok8PPo=
X-Google-Smtp-Source: AGHT+IFIbLP6gyDuDTGfvPthLs7PM+fHTJAgJYEKnyV2zl8cQka/a4lVn11JbAZoiJlrPGJ9G6k2Gg==
X-Received: by 2002:a05:600c:4fc5:b0:40b:5e56:7b44 with SMTP id o5-20020a05600c4fc500b0040b5e567b44mr2258845wmq.141.1701939776826;
        Thu, 07 Dec 2023 01:02:56 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id fa7-20020a05600c518700b0040648217f4fsm1235893wmb.39.2023.12.07.01.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:02:56 -0800 (PST)
Message-ID: <1fa25a3ce1954aadeca1973e449469795e5c78cd.camel@gmail.com>
Subject: Re: [PATCH 1/8] iio: adc: ad9467: fix reset gpio handling
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa via B4 Relay
	 <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 07 Dec 2023 10:02:56 +0100
In-Reply-To: <20231206180317.5f298685@jic23-huawei>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
	 <20231205-iio-backend-prep-v1-1-7c9bc18d612b@analog.com>
	 <20231206180317.5f298685@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-06 at 18:03 +0000, Jonathan Cameron wrote:
> On Tue, 05 Dec 2023 18:06:41 +0100
> Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > The reset gpio was being requested with GPIOD_OUT_LOW which means, not
> > asserted. Then it was being asserted but never de-asserted which means
> > the devices was left in reset. Fix it by de-asserting the gpio.
>=20
> If I understand this correctly, it's really just inverted polarity
> compared to the expectation?=C2=A0 If so just call it that rather than
> discussing what happens in detail.
>=20

Hmm, honestly I do not know but likely you're right. The driver was just pl=
aying
games with polarity and expecting people made things "right" in devicetree.

Will change the message...

- Nuno S=C3=A1
>=20

