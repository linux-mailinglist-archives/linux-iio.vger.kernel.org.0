Return-Path: <linux-iio+bounces-13982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF3A04568
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 17:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6333A5159
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16491D515B;
	Tue,  7 Jan 2025 16:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLLbge0l"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810511CAF
	for <linux-iio@vger.kernel.org>; Tue,  7 Jan 2025 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266052; cv=none; b=AD2ZK83fZwSGjrGqiTMnDXxVziknU/4kl7QLymXMoVjWJA4fVhNinQ2WFXzruKxs/9sxoQu9wYADzRNkGZPLnj9eWYqVCCLNTnWyAzpCYbBrTzNvFqMUNyKvkPKzsqQqMCE0Gi3OnDD7ALgC9cnG/CsLJs3PErBw8EJE/aKKdEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266052; c=relaxed/simple;
	bh=aRSoX098HKH8na5op7iTgXYyFXruT+sfAX552rUmZr8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JAhZP+RzrTmEK2SmzjZDmGfSaQa7fexgqK7tjXNbEvxVaQ53uw+zRws1RXDoBfhpztlRB8VfA938AnSlli5BQLkfJPczv48W3J/nNdDStWEAcSbnDZi69hqnSCaue+1+U+92qyPn4kfmIQvtFbh3E1aJgFrgIhH0tV/Q0lJs0Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLLbge0l; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso113883245e9.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Jan 2025 08:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736266048; x=1736870848; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aRSoX098HKH8na5op7iTgXYyFXruT+sfAX552rUmZr8=;
        b=KLLbge0l7Jc/A1iPTnqs0vW2GIkqUuIQJ1qOJv85kDuV4lO1qk6Xs2LiC/WAzx4ftN
         WB9TWYiGItmQFtPtJpNabx0e9LRFmvpLZFmgGK6MTt7Benea5UOCveGJaJhjd+/NxuTi
         NbQi8gBjcoPBnl+ivNaeXScEXWGYIGKIg2z1MBcXLqNPU1xdune4zJC5hoNEA3a+B2nv
         kdVXg6UPV2PX70zPtv9zy8aMzezyAvT555Y05syu2QP9KIVgKbqRgcQMJLifwNZFkjDS
         tkH21PiFPjqpwCcoohJXfFr3mPFC7m5eh+5rjxZPrK0UCDzK4eexPrszy8UbF8FAAGFl
         Ulhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736266048; x=1736870848;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRSoX098HKH8na5op7iTgXYyFXruT+sfAX552rUmZr8=;
        b=FJyEdel7yUrWLRWkPH8KrmXCzezjLBbMfbmmm65qiIa3LQ0CArLeVXXbcXSJweub5v
         cATbUMv+cnsH6AVGFkKjDPML2DTHDcQ6jZsEhfjOv07wf3eT0ln3jhwOr+T6Gqol9yto
         URF1B1z2K8i+PNSokonjCa61CePJ8P6SBHkq1l0AW/f5HoiiCLhfbVC7PWADwLmsbvnO
         WdzqlF9xH+uuj2RIi9DOiQJeUfcI+qa90Mkl8RVxTVrfz8Wt2fsE2rVpBmomnwN6eHU0
         6eb+2IJq8HRlTLCU5000KtjR6ILgwiw8YvcqEAfkTm0L3aMN5PNXDveT98R+MJ/mhJqs
         ZwCA==
X-Forwarded-Encrypted: i=1; AJvYcCW8zXPqbNfX0UeRgMDAiI+chFOqp1IlraJn9SzPkdZlev7WRd3o9V5PVSPlymallaarmviDyFZ2T34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZeR1NZ9dMHgBfAe1+h6XNp5tK33VNeY8nSdFyaR/ae9VyBC1
	e0TAcwhVntdnFh8D4sy7o2jqXdl/bL7BBAVje6XXGmYYYtFfCW0IAl6POFXI
X-Gm-Gg: ASbGncsSyOG2h26GPMVwQ4iUWU+hGa8hPzc0K9G99NWtAtJbVRnDjp1bgUvue23kfE/
	ve+8H7H8f9U2lUM3Ei99mDfKHXi1l4SzDTiVpko7+U8j7ujFU0Wc69/ThRY3rEz9qWOPZ6Moms/
	Z6SKMDbHQvFcuBueBVtjXHfIFj9kkz5sFf3MzoDiaCI1fusufcuH//wpGH+wr5vgh+Xw8sI0Okl
	xyhmEawAQ8ymHe5Km5I1un9PuVkQ+esBLOPvn52fMr3gaXGHgRB8N91Gav+O3kqr5ZLoMAkILPZ
	Dx6r+PQvx3ygljSEF2Albue62Qws
X-Google-Smtp-Source: AGHT+IGZba/C9dlGOt4FL3HiOgxVbYmD5mgjeggsa+rsVr++dG9r4kN51q+UltdM1qHebxi2RfyncQ==
X-Received: by 2002:a05:600c:4ec9:b0:435:136:75f6 with SMTP id 5b1f17b1804b1-4366790d4e9mr582808895e9.0.1736266047691;
        Tue, 07 Jan 2025 08:07:27 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4365d116d8fsm609390485e9.17.2025.01.07.08.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 08:07:27 -0800 (PST)
Message-ID: <5c4ad4326f4a177a41896d4a375e75b0540c13b1.camel@gmail.com>
Subject: Re: [RFC PATCH 00/27] iio: improve handling of direct mode claim
 and release
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 =?UTF-8?Q?=E2=80=9CLuc?= Van =?UTF-8?Q?Oostenryck=E2=80=9D?=
	 <luc.vanoostenryck@gmail.com>, David Lechner <dlechner@baylibre.com>
Date: Tue, 07 Jan 2025 16:07:26 +0000
In-Reply-To: <20250107143102.000058bc@huawei.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
		<052fb7dd2d227527e1ab97159849606ce6666868.camel@gmail.com>
	 <20250107143102.000058bc@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-07 at 14:31 +0000, Jonathan Cameron wrote:
> On Tue, 07 Jan 2025 13:09:44 +0000
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sun, 2025-01-05 at 17:25 +0000, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > Note I haven't attempted to CC relevant people for specific drivers.
> > > I'll do that for a non RFC version if we move forwards.
> > >=20
> > > Effectively two linked things in this series:
> > >=20
> > > 1) Ripping out iio_device_claim_direct_scoped()
> > > 2) Enabling use of sparse to check the claim is always released.
> > >=20
> > > The iio_device_claim_direct_scoped() was an interesting experiment
> > > built on conditional scoped guards, but it has been the source of
> > > a range of esoteric build warnings and is awkward to use.
> > > =C2=A0=20
> >=20
> > Curious about one thing... David, wouldn't your work on
> > 'if_not_cond_guard()'
> > help with this messy scoped calls? I saw it was not merged yet though..=
. Was
> > it
> > dropped for some reason?
>=20
> Link in cover letter. David's work got merged then reverted :(
>=20
> https://lore.kernel.org/all/CAHk-=3Dwi8C2yZF_y_T180-v+dSZAhps5QghS_2tKfn-=
+xAghYPQ@mail.gmail.com/
>=20
> Basically it seems to be impossible to contrive a way of doing scoped
> condition
> cleanup neatly.=C2=A0 I was also hoping we could transition to the if_con=
d_guard()
> approach to solve the scoped problems. :(
>=20

Auch, should have read the complete cover. I'll go check that thread.

Thanks!
- Nuno S=C3=A1
>=20


