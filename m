Return-Path: <linux-iio+bounces-14534-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3063A198ED
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 20:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668393ABC88
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B4021578B;
	Wed, 22 Jan 2025 19:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GfHniouR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0EA214A9B
	for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572623; cv=none; b=BgmxzJMekOhVOn82yZQnrJyM6k4MJOkw9Ts0stFHBRW3KH4FrsNxsRJppCajfvKrkfi9jLtMESARjieSkqaIq526AA3eYljnOgyBmCr5ZSWmODJyRQckxKnO36OSGDLSu69af+Un+YR0KBZ2+SRxsTIzTi1rTY4hpn8u6JGJBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572623; c=relaxed/simple;
	bh=6mBS1EmaV62tWWfoPFuAgL0jbwymuAC496G6TDauFTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KA3oSCCMj1eQNUg/IEZfKvT4AfO0bD5qL4k318tK53wyy3MzXr+CoYs8si8RLOcdvv+mMBX/+9/Y6I+6NKPuFlNwD48yJcojeIkkf5gEfsp0bN1HBKaShdiWOajHHMLwoorjz+J8j7Zf+GLvvGdHtUlMuPwSQHu+rvQtsVlaQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GfHniouR; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5187cd9b8e5so42661e0c.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 11:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1737572621; x=1738177421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok5Pch0/KAAOhoXIJBUOM74v2rEOGWSyAu8z4dZq+c0=;
        b=GfHniouRJn/UlB03FLSGhPNkjes25kYagvzUxSBCHzLfJwf11oP4hpW/97KS5F7LwQ
         Enb47DUaUM8oD+7ISxfdUsq9p7KkCjwIw9qhWgOFVKpyFhJ29jo38kBksLcC75Um24+7
         iIg6T5aVet2LcCpAiwd40gFtI0bedkJybbGP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737572621; x=1738177421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok5Pch0/KAAOhoXIJBUOM74v2rEOGWSyAu8z4dZq+c0=;
        b=FPsH/MWjR/OfLn9n3wsVf4aq/X7/knHZ75DK0O+4T1BkrClku04ka2JeoOzCeEXIbH
         x+jgXZ8c/RibM1T4MXUgie6ZEN6XQyKxZDedPxOBDS1R/5MuXfw6A+cd75Vc2rqSNTy2
         6E0jq6JzyOImLmW9CHwGlRrKmHNPwQLPxRVN7+3twGEkwWE0ozFrf15gjw8EMyBriJ8j
         6SxNmzIYaTzd2kPVBRIMsp9lADj+jT7rJiRqLLv4iN+RC5JgHVJA6kbduxMtFF+xsbu8
         FhAZ4aXGHyNxZ5doIelmdEYw6sS0LlKoSemQlMdqDFixpjSmW+zYzl+gY2cSvXf99ECd
         cPVA==
X-Forwarded-Encrypted: i=1; AJvYcCUnAlQYVdZdl+zu6mudn+IFOplvOQd7sy9R5anF/wn3T5DCbxaTW+o/JOHQBEi8briGbUto9hyekV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5PKI0rOIAvO2tAo37Ug0E9V9nTFODB+NODmK7soDJirgR7FF
	6XwODgAffuTBDKbQbjm+CEz8Qbpw009Hb1kFqXjsSH/jphgkEL6Spt9s80p4Sa1AoUgdSnFhF4U
	cBXcOA/F15ZIKyrdephxgd+WkLU/czLO1SNS1+Wy8yemPsGmRKQ==
X-Gm-Gg: ASbGncuPdmockam4bUh7ccvYHJXTgNCnkUz/wbam4kBpCwd7pr9kRgfnhT2Bvoky+VO
	T3asp+diuN+wGoI1Lf20bMSUcL3r8LCC8pnN6GzZcQi92W4myDzG/q+FFyh+cYoQRACClfARWFe
	8=
X-Google-Smtp-Source: AGHT+IFyvhlQN1NG9Hm2CbL+YC9Xx3HqS+rGbWa5t3AGlj0DW2w+lGysTnU64CEmPdPlyRGEPcDKnvc79+prRoWFOhs=
X-Received: by 2002:a05:6122:2402:b0:518:a0ac:1f42 with SMTP id
 71dfb90a1353d-51d592ca33amr16334201e0c.1.1737572620987; Wed, 22 Jan 2025
 11:03:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117230136.2237346-1-gwendal@chromium.org>
 <20250118162748.6badf0ab@jic23-huawei> <Z44OaSCdFeCygJLQ@google.com>
 <CAPUE2utb_L0rhjN6BdY2WEOX3i48DiTAkytY=WLgjbymrZc6Tw@mail.gmail.com> <Z5CK8ltaZM6Z85Wi@google.com>
In-Reply-To: <Z5CK8ltaZM6Z85Wi@google.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 22 Jan 2025 11:03:29 -0800
X-Gm-Features: AbW1kvbeBdXPr-WZ5XK2pQ8UiqyIS77DwjJAw8UKqlkHNdLyZoDpyhLV8qYJCJo
Message-ID: <CAPUE2usSx4mc7H7CjL5JK-c+0mA7S7G+BuPOimvuyO0cVT-L-A@mail.gmail.com>
Subject: Re: [PATCH v3] iio: cros_ec: Trace EC sensors command
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 10:06=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Tue, Jan 21, 2025 at 01:54:31PM -0800, Gwendal Grignou wrote:
> > On Mon, Jan 20, 2025 at 12:50=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.=
org> wrote:
> > >
> > > On Sat, Jan 18, 2025 at 04:33:52PM +0000, Jonathan Cameron wrote:
> > > > I briefly applied this, but...
> > > >
> > > > [jic23@jic23-huawei iio]$ make LOCALVERSION=3D W=3D1 -j12  C=3D1
> > > > mkdir -p /home/jic23/src/kernel/iio/tools/objtool && make O=3D/home=
/jic23/src/kernel/iio subdir=3Dtools/objtool --no-print-directory -C objtoo=
l
> > > >   CALL    scripts/checksyscalls.sh
> > > >   INSTALL libsubcmd_headers
> > > >   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.o
> > > >   CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.=
o
> > > > In file included from drivers/iio/common/cros_ec_sensors/cros_ec_se=
nsors_trace.h:56,
> > > >                  from drivers/iio/common/cros_ec_sensors/cros_ec_se=
nsors_trace.c:32:
> > > > ./include/trace/define_trace.h:106:42: fatal error: ./cros_ec_senso=
rs_trace.h: No such file or directory
> > > >   106 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > > >       |                                          ^
> > > >
> > > > Despite dealing with trace points a lot in the day job
> > > > I still find them hard to actually add to a subsystem because
> > > > of fun things like this one.
> > I reproduced this error on a fresh kernel source tree. I suspect an
> > issue with sparse, as other trace.c files use __CHECKER__ macros. For
> > instance `drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c`:
> >
> >  10 /* sparse doesn't like tracepoint macros */
> >  11 #ifndef __CHECKER__
> > ...
>
> I still can't reproduce the error by using a just-cloned kernel source tr=
ee
> with C=3D1.  Could you provide some more details about your steps?  I'm
> wondering about which steps I may miss.
first, I checked sparse is new enough:
sparse --version
0.6.4 (Debian: 0.6.4-4)

Then
mkdir linux-iio
cd linux-iio
git init
git remote add iio  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio=
.git
git fetch iio
git checkout -b togreg iio/togreg
git am  ...-sensors-command.patch
make menuconfig  # accept the default
make LOCALVERSION=3D W=3D1 -j12  C=3D1

But there is still a mystery: looking around, there is no consensus
for TRACE_INCLUDE_PATH. Out of 157 definitions, 107 uses `.`, 39 uses
`../../drivers/....`, and 10 something else:
find drivers/ -name \*trace\*h -exec grep -re "^#define
TRACE_INCLUDE_PATH " {} \+ | wc -l
156
find drivers/ -name \*trace\*h -exec grep -re "^#define
TRACE_INCLUDE_PATH .$" {} \+ | wc -l
107
find drivers/ -name \*trace\*h -exec grep -re "^#define
TRACE_INCLUDE_PATH ../../drivers" {} \+ | wc -l
39

I am guessing it depends on the included paths added to the command
line used to invoke the compiler.

