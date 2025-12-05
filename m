Return-Path: <linux-iio+bounces-26784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E69ABCA7869
	for <lists+linux-iio@lfdr.de>; Fri, 05 Dec 2025 13:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7BED310EECC
	for <lists+linux-iio@lfdr.de>; Fri,  5 Dec 2025 11:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D40129D26C;
	Fri,  5 Dec 2025 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lme8MOYU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CCB32252E
	for <linux-iio@vger.kernel.org>; Fri,  5 Dec 2025 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764933886; cv=none; b=FLdQgwp7PPgPGsljS2/7azdia5tYolvab9uWlyHSuJ/u9U3GHillYai1Sq9v8CHDPZvjgTFjfpjwizYZ+9wd7miFX/ajwhfv+uFks2nvHqJRmyy4VsKs4EYMImNKnOLUuo1xsVsjo9SiwaCXIxlOQGux2y2+C/xs3nGKJIGrYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764933886; c=relaxed/simple;
	bh=CKHxZWd0nxOJAJRmoA7WZ7lxOJd/RDNnrDN+rfX2sfY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVHDKe/XuHkEvmjTY6ZOlKDO2/S5O1bx06n2zpv/IWCRzuxznibrU5GSH48AHzKsB5qFmc0mG46/ogAE+Te7DJ7qB+CyQYayvh+Ze8dkrxPemV5gHFXV415I4vLFrU7vx105LDxKcUjgpAzSASa9lVMdVyC/CWH6+I+L1FL9cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lme8MOYU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47796a837c7so16515385e9.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Dec 2025 03:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764933881; x=1765538681; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CKHxZWd0nxOJAJRmoA7WZ7lxOJd/RDNnrDN+rfX2sfY=;
        b=Lme8MOYUvOnxDkY/HOR2ZR8Y5kl4MhgbU46tjeCmZrwEUD30dB8nqLeL5lqk35EXCq
         llBXJvy0TJ9we0vzTJICsRfgMM6ac59zQcfOywvTQkBERiD6v2wzECPjAtSqFrDlStU9
         ZCicer+FPSoi0PTKvqtWfaGth+Fz3gLLcN13MVPii7tRoBxBOe3l6xeqMthvQdekc9CO
         bMMIFe7d2ZQ9FZNJb+ppe5ugVpvpc0fj7qdeNha2FYTtiiApDBOuLlCki4MNnF7yC4zG
         sgGDZ3JvDwrDIBhbFOa9NIdyhUhXZJodGthcAvUacmB19qEkC+h/7czAr9i40tPCNzV/
         dzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764933881; x=1765538681;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKHxZWd0nxOJAJRmoA7WZ7lxOJd/RDNnrDN+rfX2sfY=;
        b=FpY7MEM65WTZK6DGfaVaQHtSeNrv0uiAEbOYucHqhnRojcOgeqQlVmyLwtiWmDBEfL
         dybX+fi5NSl8ig9tarZuw6dxbYpbltVhanB3BgnOLY5Q3atDmvjME1XIIfOfDIgpLqDh
         AJndH8q//N+hJ+olXrcHPNGwCuGjheEl7W0orNYwzdxbkwDCm73RIT63rah5goy7ocnr
         UQkUVSdGzCyeF07mfPmLfeti5dEMs4O54mSiV20K0/g+IXYv0bMihl+uQv1DSV3z4mRl
         DJlhf9RE+fgxmlF+WuOfdwh+TqgcpnHT/Y9aQGXVSVDjPHKt2RlZNRPxtP8eGrH1UxgN
         MXOg==
X-Gm-Message-State: AOJu0YzshCmNkZnvCG79UekE0wAnvEgIC7lf+zQxy93ZdSvFfvpnJbm3
	iKOEc2q/1k7amVXDZC48LnzChWgTlt2Phy5JO+8lGjb6X+EOLN71Jx7W
X-Gm-Gg: ASbGncsPr7jB3LsMhzu89tptQSKKMPyHA5YAOwbXubOOM2wGWFhxrsZ5kV2NUtB5Rnn
	0gFeFgwFUobDwyOnkKjcCAVLOZoxcO8ijxqNdihJUNPqfz6MxfFm4TZ5o04TEv+szeFKDZYMM2r
	KVNfYRLgsNAPcdik6EUi3G3udcTUPb3A+JVySzqZGNE1+XlmRh7HdBg0A/P8vyV5nRAVs83PSQe
	Yqr06iuwYbqoEDtO0lQKD/HQ3bYW1JEPgcwYmBu4AjnkfkXSV8gwXZZEN1gx2xBpt8apifXdCGa
	yUUiYqgdaxyw+cdC9RjZMSKrE04Xc8ivDwSZMWfB3LRfaiPSNHPttfyre2lz6w274DxqolDWDJ3
	3bj+F0Td2HJ5jidxIJX5kU17/TDb0ALOQTRr7x9sjPtE3GDLYV6shKPTKdLu6RgUKhxqcNnHDI7
	oLtipEACq33cCsVNAHTbo=
X-Google-Smtp-Source: AGHT+IFbRNEcalNJJQjoeqFFbO+sElApz6wWmGA/mZ+fSBRL2Oy023mle0mailhub/DL9wQwfjsmZQ==
X-Received: by 2002:a05:600c:4689:b0:477:73e9:dbe7 with SMTP id 5b1f17b1804b1-4792af607f4mr108627915e9.35.1764933880561;
        Fri, 05 Dec 2025 03:24:40 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47936f651dfsm10747805e9.5.2025.12.05.03.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 03:24:40 -0800 (PST)
Message-ID: <d385344e47410305be75aed6ad1d1183cb93d450.camel@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: adi-axi-adc: Turn dev_info() into
 dev_dbg()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron	 <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko	 <andy@kernel.org>
Date: Fri, 05 Dec 2025 11:25:20 +0000
In-Reply-To: <CAHp75Vc46cy7vGPAHksFB5QT0Mc_ztGaODtyLeEQHveNrYKg=Q@mail.gmail.com>
References: <20251204-iio-axi-adc-minor-change-v1-0-2d441d6c5b65@analog.com>
	 <20251204-iio-axi-adc-minor-change-v1-2-2d441d6c5b65@analog.com>
	 <CAHp75Vc46cy7vGPAHksFB5QT0Mc_ztGaODtyLeEQHveNrYKg=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-12-04 at 21:11 +0200, Andy Shevchenko wrote:
> On Thu, Dec 4, 2025 at 5:23=E2=80=AFPM Nuno S=C3=A1 via B4 Relay
> <devnull+nuno.sa.analog.com@kernel.org> wrote:
>=20
> > We should not abuse logging and logging a successful probe is clearly
> > abuse. Turn it into dev_dbg().
> >=20
> > If it turns out the IP version is that relevant we can make it easy to
> > get through a new debugfs interface later on.
>=20
> Hmm... This prints a version information. Does the user have different
> means to get the same information?

It can read it directly from the registers through debugFS. But is that a b=
locker? I mean,
there are tons of devices where we could potentially print some product_id =
or silicion rev but that
should not be a reason for bloating the console, right? Or is your argument=
 that once done, it's a
bad to take it back?

As mentioned in the commit message, we could add a "version" debugFS file t=
o print the same info but
that would require a bit more work.

Anyways, if too much trouble, I can drop the patch...

- Nuno S=C3=A1

