Return-Path: <linux-iio+bounces-419-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51977F9B3F
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 09:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5E21C208A3
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 08:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B449B10A17;
	Mon, 27 Nov 2023 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBf5orN4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBF5138
	for <linux-iio@vger.kernel.org>; Mon, 27 Nov 2023 00:04:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so5226793a12.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Nov 2023 00:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701072251; x=1701677051; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8Boyz7e+qIudc3yq8XRVM4MAQRhers6RZrmb3kF3VE=;
        b=NBf5orN43fPsL1Tx2eOZaffrqqKH3g6xLGTbBNpAokctT0hH710fVYidjqZCavy/Ah
         gU6+jCeX5ATToqALxm8dsAIwj4L5bulIs6q2JqfihrBBYT4hbO62tYePDF2b+BH0fAKu
         D3QDMYX7PdnyLdOpua4ea/G/U8XeejDj8Sg+vc7btweELbl8TxbZoycmSp8UIpNzqccS
         TgakyrAEAV7C6RDE6NK02hAP76ZorRhkvYJIUNxI5H5aWsqNyp2ofzdq4z22I1xHmXV8
         E+DQ73uz4uHy+3g1zEzCaz/oYiHfADOi3QHl+ZJjlInjF8eYVEbdzlptBUQX4ZxbMk89
         g7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701072251; x=1701677051;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y8Boyz7e+qIudc3yq8XRVM4MAQRhers6RZrmb3kF3VE=;
        b=LjVkSPZf0oBCceajOrCv1MM3SqFoGmW66OCXq1S+kt4qHz09t5jrKWbTOSKMD42syf
         uXhFaw9Z/RtTiNqN2R97ExXfelfHSZ4iqan3NbbfrD65xdcnStZv4wkV5QzgpSbG5Lp+
         FAjsfl6UKeB6yj7frcIIi1h9dvzlFzvd+Z842OVk+bzq2W1a9XDa4tJxD9A7jLQ3lsBV
         ZXizgFykgVuPSy4jk/bsxzSnl4x5wi+/1QAONyBvVNnEcVKbQAddzJx1rIXAf/Vllz9L
         /EkGJAZ0dHm30nYstwMxWg9PRGQKX5kWCyKmRCGssSrM0oAIshPLs84Y+xSiwzS1MsnD
         h5fg==
X-Gm-Message-State: AOJu0YyQ6IVSGyBxH/h838P2ymummRf2QiOoem4DMM3Y9VKjxOjrzDWG
	FnpuHG1924vLSDARu+4U6IY=
X-Google-Smtp-Source: AGHT+IEDnmnLBsGqYnl+yes2oPEkxxZ3tdxI2gEcc/wBQvljWrmDcWEnKbuUHqZQxWhbMZsWipm1gw==
X-Received: by 2002:a50:d55e:0:b0:542:eb1f:c70a with SMTP id f30-20020a50d55e000000b00542eb1fc70amr7838735edj.29.1701072251029;
        Mon, 27 Nov 2023 00:04:11 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id o4-20020aa7dd44000000b00548a3a22d66sm4943833edw.41.2023.11.27.00.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:04:10 -0800 (PST)
Message-ID: <26638581f048a327f4a4dc58d57ac454ae2029c2.camel@gmail.com>
Subject: Re: IIO: Playing catch up.
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Date: Mon, 27 Nov 2023 09:04:10 +0100
In-Reply-To: <20231126183650.08b98393@jic23-huawei>
References: <20231123190044.4fb992f1@jic23-huawei>
	 <20231123190341.088b4951@jic23-huawei>
	 <20231126183650.08b98393@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-11-26 at 18:36 +0000, Jonathan Cameron wrote:
> On Thu, 23 Nov 2023 19:03:41 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Thu, 23 Nov 2023 19:00:44 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >=20
> > > Hi all,
> > >=20
> > > Unfortunately I didn't get nearly as much time to do normal reviews e=
tc in the
> > > last few weeks due to travel and resulting day job pile up.=C2=A0 I'l=
l catch up, but
> > > might
> > > take a little while yet before we get back to normal target (I aim fo=
r within 2
> > > weeks of
> > > posting.)=C2=A0 It's early in the cycle so hopefully this shouldn't d=
elay anything
> > > too much!
> > >=20
> > > Jonathan
> > >=20
> > > p.s. LPC was fun/mad. Was great to meet some new people f2f - apologi=
es for my
> > > terrible
> > > memory for names!=C2=A0 Thoroughly recommend attending LPC at least o=
nce (I believe
> > > it's
> > > in Europe next year)
> > > =C2=A0=20
> >=20
> > Forgot to say: Thanks to all those who do reviews for IIO, it particula=
rly helps
> > at
> > times like this as well as often catching things I miss. Everyone looks=
 at code
> > differently,
> > so the set of reviewers we have for IIO is wonderful!=C2=A0 More always=
 welcome :)
> >=20
> > Jonathan
> >=20
>=20
> With exception of Nuno's new version of the backend framework I think I'v=
e caught
> up
> (sigh - that was a pair of long sessions but nice to be moderately on top=
 of things
> again)=C2=A0 Bad luck Nuno, your work is too complex for a evening review=
! :)
>=20

No worries. You already do a lot :).

- Nuno S=C3=A1


