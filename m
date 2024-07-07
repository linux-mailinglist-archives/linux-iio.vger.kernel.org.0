Return-Path: <linux-iio+bounces-7389-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BE4929772
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 12:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450131C209F9
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 10:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A45D18B14;
	Sun,  7 Jul 2024 10:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT4LnrQh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38E41862C;
	Sun,  7 Jul 2024 10:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720348719; cv=none; b=lD/2054b7Fi12NRq4hgt5LBZbz6CVgBnYvCYuoXx9RTvTa06hdZDLbo2SUYbceah6LEQKgOrw8DbXyTeOvVg83MjKedtDBja7ETwdWWSsNtEyZ5ZsgRt0ujxZyUJbg3bq0Zwhe0ob5zPa6jiAcdiBG2ObAHOTm6n0tRI1j3nvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720348719; c=relaxed/simple;
	bh=uNXXhiM1YnJJ58BhSBQ+0ikKYaqQBgUhVEVHTpXyhdk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFwCPitZohu4dRXT5INbTRe1wG5fsZR2NG5Zc1OeynmL5l3clvtTlVhglUv10YfK9BIPDMcPUgIx+yGwS1iUOgj77Ho+96LqT3Go7eJ6696ftKGlT7rLEtdbi72B3hiqjcHBDoT7Z3k8jfKIh2FmTnX9Xrt14AQeC7G46wSKttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT4LnrQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C90C3277B;
	Sun,  7 Jul 2024 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720348719;
	bh=uNXXhiM1YnJJ58BhSBQ+0ikKYaqQBgUhVEVHTpXyhdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fT4LnrQhYBRLen+6EjLqSEAxwy5Jk7DAyWQoHorfaYfpct8EP7YI0G028j3g6xcrd
	 8tl2NCzWeMx5Xm5z+BC7HApAovwFHuhqB5bPQrqpz0MhqkI59ScraE9loeLTI31Znw
	 P8At3D0YN3JQ4GtfmqQdaCdOVaj6+IeM+7HDXj7dIoQRnXqK+5pIxdSIQ7WuRtN5fQ
	 r2jOpAyefdqs5ck3BfYVtyDX36CDxg6eM2+3Pk49yN/g9xPNjTjqdlJ0tFb2rogvv0
	 qLozjyX4e6pjOW6lp5Ml3y4M+MhT+pwU/Pv3WwRkHQ5SnHIrQgDdIa/VcI7EA84//w
	 kPapeUurVylIw==
Date: Sun, 7 Jul 2024 11:38:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Guillaume Stols <gstols@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 devicetree@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 jstephan@baylibre.com, dlechner@baylibre.com, Conor Dooley
 <conor.dooley@microchip.com>, tools@kernel.org
Subject: Re: [PATCH v3 0/8] iio: adc: ad7606: Improvements
Message-ID: <20240707113830.346fced4@jic23-huawei>
In-Reply-To: <20240706-funny-flamingo-of-temperance-9d1e85@lemur>
References: <20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com>
	<20240706131549.1f94449c@jic23-huawei>
	<20240706-funny-flamingo-of-temperance-9d1e85@lemur>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Jul 2024 08:29:28 -0400
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> On Sat, Jul 06, 2024 at 01:15:49PM GMT, Jonathan Cameron wrote:
> > This series is blowing up with b4, in that it is finding tags that were
> > not given and I can't work out why.
> >=20
> > Tried various options but even a simple b4 am -l 20240702-cleanup-ad760=
6-v3-0-57fd02a4e2aa@baylibre.com
> > Is merrily finding tags that I can find no record of. =20
>=20
> I can't replicate this, so something else is going on. Can you try:
>=20
>     b4 --no-cache am -l 20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibr=
e.com

Moved the no-cache after am as otherwise unrecognised parameter.
Not seeing any change to results.

>=20
> In either case, I want to see the output of:
>=20
>     b4 -d am -l 20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com 2>=
/tmp/b4-debug

Running git --no-pager rev-parse --show-toplevel
Running git --no-pager config -z --get-regexp b4\..*
Running git --no-pager config -z --get-regexp gpg\..*
Running git --no-pager config -z --get-regexp user\..*
Running git --no-pager config -z --get-regexp sendemail\.[^.]+$
Using values from sendemail
t_mbx_url=3Dhttps://lore.kernel.org/all/20240702-cleanup-ad7606-v3-0-57fd02=
a4e2aa@baylibre.com/t.mbox.gz
Grabbing thread from lore.kernel.org/all/20240702-cleanup-ad7606-v3-0-57fd0=
2a4e2aa@baylibre.com/t.mbox.gz
Mailsplitting the mbox into /tmp/tmp5ftpkxzs-mailsplit
Running git --no-pager mailsplit --mboxrd -o/tmp/tmp5ftpkxzs-mailsplit
Looking at: 20240702-cleanup-ad7606-v3-1-57fd02a4e2aa@baylibre.com
Kept in thread: 20240702-cleanup-ad7606-v3-1-57fd02a4e2aa@baylibre.com
Looking at: 20240702-cleanup-ad7606-v3-2-57fd02a4e2aa@baylibre.com
Kept in thread: 20240702-cleanup-ad7606-v3-2-57fd02a4e2aa@baylibre.com
Looking at: 20240702-cleanup-ad7606-v3-3-57fd02a4e2aa@baylibre.com
Kept in thread: 20240702-cleanup-ad7606-v3-3-57fd02a4e2aa@baylibre.com
Looking at: 20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com
Kept in thread: 20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@baylibre.com
Looking at: 20240702-cleanup-ad7606-v3-4-57fd02a4e2aa@baylibre.com
Kept in thread: 20240702-cleanup-ad7606-v3-4-57fd02a4e2aa@baylibre.com
Looking at: 20240702-cleanup-ad7606-v3-6-57fd02a4e2aa@baylibre.com
Kept in thread: 20240702-cleanup-ad7606-v3-6-57fd02a4e2aa@baylibre.com
Looking at: 20240702-cleanup-ad7606-v3-5-57fd02a4e2aa@baylibre.com
Kept in thread: 20240702-cleanup-ad7606-v3-5-57fd02a4e2aa@baylibre.com
Looking at: 20240702-cleanup-ad7606-v3-7-57fd02a4e2aa@baylibre.com
Kept in thread: 20240702-cleanup-ad7606-v3-7-57fd02a4e2aa@baylibre.com
Looking at: 20240702-cleanup-ad7606-v3-8-57fd02a4e2aa@baylibre.com
Kept in thread: 20240702-cleanup-ad7606-v3-8-57fd02a4e2aa@baylibre.com
Looking at: 17e484a2c07c0a521120a6a3cab7dfcf5f3c2fee.camel@gmail.com
Kept in thread: 17e484a2c07c0a521120a6a3cab7dfcf5f3c2fee.camel@gmail.com
Looking at: 429af3d1afe4297dde5c8795ca745d84d52e5033.camel@gmail.com
Kept in thread: 429af3d1afe4297dde5c8795ca745d84d52e5033.camel@gmail.com
Looking at: 8010eaf5300d2dcf928812693379b649b77f0e0f.camel@gmail.com
Kept in thread: 8010eaf5300d2dcf928812693379b649b77f0e0f.camel@gmail.com
Looking at: 20240706131549.1f94449c@jic23-huawei
Kept in thread: 20240706131549.1f94449c@jic23-huawei
Looking at: 20240706-funny-flamingo-of-temperance-9d1e85@lemur
Kept in thread: 20240706-funny-flamingo-of-temperance-9d1e85@lemur
Looking at: 4d47b8c3-2f36-4325-b288-0faa40f876eb@web.de
Kept in thread: 4d47b8c3-2f36-4325-b288-0faa40f876eb@web.de
Analyzing 15 messages in the thread
Ignoring 24:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 34:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 44:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 56:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 71:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 80:      maxItems: 3 (not a recognized non-person trailer)
Ignoring 95:      type: boolean (not a recognized non-person trailer)
Looking at: [PATCH v3 1/8] dt-bindings: iio: adc: adi,ad7606: normalize tex=
twidth
  adding as patch
Ignoring 14:    avcc-supply: true (not a recognized non-person trailer)
Ignoring 20:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 32:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 45:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 58:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 67:      maxItems: 3 (not a recognized non-person trailer)
Ignoring 83:      type: boolean (not a recognized non-person trailer)
Looking at: [PATCH v3 2/8] dt-bindings: iio: adc: adi,ad7606: improve descr=
iptions
  adding as patch
Ignoring 15:    avcc-supply: true (not a recognized non-person trailer)
Looking at: [PATCH v3 3/8] dt-bindings: iio: adc: adi,ad7606: add supply pr=
operties
  adding as patch
Ignoring 33:       dt-bindings: iio: adc: adi,ad7606: normalize textwidth (=
not a recognized non-person trailer)
Ignoring 34:       dt-bindings: iio: adc: adi,ad7606: improve descriptions =
(not a recognized non-person trailer)
Ignoring 35:       dt-bindings: iio: adc: adi,ad7606: add supply properties=
 (not a recognized non-person trailer)
Ignoring 36:       dt-bindings: iio: adc: adi,ad7606: fix example (not a re=
cognized non-person trailer)
Ignoring 37:       dt-bindings: iio: adc: adi,ad7606: add conditions (not a=
 recognized non-person trailer)
Ignoring 38:       iio: adc: ad7606: fix oversampling gpio array (not a rec=
ognized non-person trailer)
Ignoring 39:       iio: adc: ad7606: fix standby gpio state to match the do=
cumentation (not a recognized non-person trailer)
Ignoring 40:       iio: adc: ad7606: switch mutexes to scoped_guard (not a =
recognized non-person trailer)
Looking at: [PATCH v3 0/8] iio: adc: ad7606: Improvements
  adding as v3 cover letter
Looking at: [PATCH v3 4/8] dt-bindings: iio: adc: adi,ad7606: fix example
  adding as patch
Looking at: [PATCH v3 6/8] iio: adc: ad7606: fix oversampling gpio array
  adding as patch
Ignoring 93:  unevaluatedProperties: false (not a recognized non-person tra=
iler)
Looking at: [PATCH v3 5/8] dt-bindings: iio: adc: adi,ad7606: add conditions
  adding as patch
Looking at: [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio state to matc=
h the documentation
  adding as patch
Looking at: [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to scoped_guard
  adding as patch
Looking at: Re: [PATCH v3 6/8] iio: adc: ad7606: fix oversampling gpio array
  adding to followups
Looking at: Re: [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio state to =
match the documentation
  adding to followups
Looking at: Re: [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to scoped_g=
uard
  adding to followups
Looking at: Re: [PATCH v3 0/8] iio: adc: ad7606: Improvements
  adding to followups
Looking at: Re: [PATCH v3 0/8] iio: adc: ad7606: Improvements
  adding to followups
Looking at: Re: [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to scoped_g=
uard
  adding to followups
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
full_threads specified, adding t=3D1
Using cached copy: /home/jic23/.cache/b4/3bbd0dc0edd87cc84b84b8e5684b244bc5=
ee9b43.pi.msgs
Retrieved 65 matching code-review messages
Ignoring 92:  unevaluatedProperties: false (not a recognized non-person tra=
iler)
Ignoring 53:  Base: using specified base-commit 07d4d0bb4a8ddcc463ed599b22f=
510d5926c2495 (not a recognized non-person trailer)
Ignoring 54: Applying: dt-bindings: iio: adc: adi,ad7606: add missing datas=
heet link (not a recognized non-person trailer)
Ignoring 55: Applying: dt-bindings: iio: adc: adi,ad7606: comment and sort =
the compatible names (not a recognized non-person trailer)
Ignoring 56: Applying: dt-bindings: iio: adc: adi,ad7606: normalize textwid=
th (not a recognized non-person trailer)
Ignoring 57: Applying: dt-bindings: iio: adc: adi,ad7606: improve descripti=
ons (not a recognized non-person trailer)
Ignoring 58: Applying: dt-bindings: iio: adc: adi,ad7606: add supply proper=
ties (not a recognized non-person trailer)
Ignoring 59: Applying: dt-bindings: iio: adc: adi,ad7606: fix example (not =
a recognized non-person trailer)
Ignoring 60: Applying: dt-bindings: iio: adc: adi,ad7606: add conditions (n=
ot a recognized non-person trailer)
Ignoring 61: Applying: iio: adc: ad7606: fix oversampling gpio array (not a=
 recognized non-person trailer)
Ignoring 62: Applying: iio: adc: ad7606: fix standby gpio state to match th=
e documentation (not a recognized non-person trailer)
Ignoring 63: Applying: iio: adc: ad7606: switch mutexes to scoped_guard (no=
t a recognized non-person trailer)
Ignoring 14:  description: | (not a recognized non-person trailer)
Ignoring 14:    avcc-supply: true (not a recognized non-person trailer)
Ignoring 7: url:    https://github.com/intel-lab-lkp/linux/commits/Guillaum=
e-Stols/dt-bindings-iio-adc-adi-ad7606-add-missing-datasheet-link/20240618-=
223010 (not a recognized non-person trailer)
Ignoring 8: base:   07d4d0bb4a8ddcc463ed599b22f510d5926c2495 (not a recogni=
zed non-person trailer)
Ignoring 11: config: x86_64-randconfig-101-20240619 (https://download.01.or=
g/0day-ci/archive/20240619/202406191142.rs8moLqC-lkp@intel.com/config) (not=
 a recognized link trailer)
Ignoring 12: compiler: clang version 18.1.5 (https://github.com/llvm/llvm-p=
roject 617a15a9eac96088ae5e9134248d8236e34b91b1) (not a recognized non-pers=
on trailer)
Ignoring 13:    avcc-supply: true (not a recognized non-person trailer)
Ignoring 19:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 30:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 41:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 51:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 63:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 80:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 91:      maxItems: 3 (not a recognized non-person trailer)
Ignoring 108:      type: boolean (not a recognized non-person trailer)
Ignoring 14:  description: | (not a recognized non-person trailer)
Ignoring 14:    avcc-supply: true (not a recognized non-person trailer)
Ignoring 23:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 33:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 43:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 55:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 70:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 79:      maxItems: 3 (not a recognized non-person trailer)
Ignoring 94:      type: boolean (not a recognized non-person trailer)
Ignoring 13:    avcc-supply: true (not a recognized non-person trailer)
Ignoring 19:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 31:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 44:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 57:      maxItems: 1 (not a recognized non-person trailer)
Ignoring 66:      maxItems: 3 (not a recognized non-person trailer)
Ignoring 82:      type: boolean (not a recognized non-person trailer)
Ignoring 26:       dt-bindings: iio: adc: adi,ad7606: add missing datasheet=
 link (not a recognized non-person trailer)
Ignoring 27:       dt-bindings: iio: adc: adi,ad7606: comment and sort the =
compatible names (not a recognized non-person trailer)
Ignoring 28:       dt-bindings: iio: adc: adi,ad7606: normalize textwidth (=
not a recognized non-person trailer)
Ignoring 29:       dt-bindings: iio: adc: adi,ad7606: improve descriptions =
(not a recognized non-person trailer)
Ignoring 30:       dt-bindings: iio: adc: adi,ad7606: add supply properties=
 (not a recognized non-person trailer)
Ignoring 31:       dt-bindings: iio: adc: adi,ad7606: fix example (not a re=
cognized non-person trailer)
Ignoring 32:       dt-bindings: iio: adc: adi,ad7606: add conditions (not a=
 recognized non-person trailer)
Ignoring 33:       iio: adc: ad7606: fix oversampling gpio array (not a rec=
ognized non-person trailer)
Ignoring 34:       iio: adc: ad7606: fix standby gpio state to match the do=
cumentation (not a recognized non-person trailer)
Ignoring 35:       iio: adc: ad7606: switch mutexes to scoped_guard (not a =
recognized non-person trailer)
Ignoring 82:  unevaluatedProperties: false (not a recognized non-person tra=
iler)
Ignoring 13:       dt-bindings: iio: adc: adi,ad7606: add missing datasheet=
 link (not a recognized non-person trailer)
Ignoring 14:       dt-bindings: iio: adc: adi,ad7606: comment and sort the =
compatible names (not a recognized non-person trailer)
Ignoring 15:       dt-bindings: iio: adc: adi,ad7606: improve descriptions =
(not a recognized non-person trailer)
Ignoring 16:       dt-bindings: iio: adc: adi,ad7606: add supply properties=
 (not a recognized non-person trailer)
Ignoring 17:       dt-bindings: iio: adc: adi,ad7606: add conditions (not a=
 recognized non-person trailer)
Ignoring 18:       dt-bindings: iio: adc: adi,ad7606: fix example (not a re=
cognized non-person trailer)
Ignoring 19:       iio: adc: ad7606: switch mutexes to scoped_guard (not a =
recognized non-person trailer)
Ignoring 20:       iio: adc: ad7606: fix oversampling gpio array (not a rec=
ognized non-person trailer)
Ignoring 21:       iio: adc: ad7606: fix standby gpio state to match the do=
cumentation (not a recognized non-person trailer)
Analyzing 50 code-review messages
  new message: 171985401324.129711.10327596818735583111.robh@kernel.org
Running git --no-pager patch-id --stable
  found matching patch-id for dt-bindings: iio: adc: adi,ad7606: normalize =
textwidth
  new message: 20240623163130.4a72707b@jic23-huawei
  skipping reply without trailers: 20240623163130.4a72707b@jic23-huawei
  new message: 20240618-oval-parish-d3fa2925a52a@spud
  found a cover letter for dt-bindings: iio: adc: adi,ad7606: add conditions
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
  found matching patch-id for dt-bindings: iio: adc: adi,ad7606: add condit=
ions
  new message: 20240618-cleanup-ad7606-v1-7-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-7-f1854d5c779d@baylibre.com
  new message: 12e5c4b4-e51d-4e69-8c63-3f6aefb574d9@baylibre.com
  skipping reply without trailers: 12e5c4b4-e51d-4e69-8c63-3f6aefb574d9@bay=
libre.com
  new message: 20240628-cleanup-ad7606-v2-7-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-7-96e02f90256d@baylibre.com
  new message: 20240629162223.5b8d35b8@jic23-huawei
  skipping reply without trailers: 20240629162223.5b8d35b8@jic23-huawei
  new message: 20240628-postwar-scaling-cb7d7b1f4f3c@spud
  skipping reply without trailers: 20240628-postwar-scaling-cb7d7b1f4f3c@sp=
ud
  new message: 20240623164126.0cf96981@jic23-huawei
  skipping reply without trailers: 20240623164126.0cf96981@jic23-huawei
  new message: 20240630-darling-dairy-f161f784f45a@spud
  skipping reply without trailers: 20240630-darling-dairy-f161f784f45a@spud
  new message: 20240618-cleanup-ad7606-v1-1-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-1-f1854d5c779d@baylibre.com
  new message: 20240618-cleanup-ad7606-v1-6-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-6-f1854d5c779d@baylibre.com
  new message: 20240618-cleanup-ad7606-v1-4-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-4-f1854d5c779d@baylibre.com
  new message: 20240628-sworn-vegan-be51d695ba52@spud
  found a cover letter for dt-bindings: iio: adc: adi,ad7606: add conditions
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
Running git --no-pager patch-id --stable
  found matching patch-id for dt-bindings: iio: adc: adi,ad7606: add condit=
ions
  new message: 20240623163508.4e0bdb8b@jic23-huawei
  skipping reply without trailers: 20240623163508.4e0bdb8b@jic23-huawei
  new message: 171952025424.477297.14698127361119381011.robh@kernel.org
  found matching patch-id for dt-bindings: iio: adc: adi,ad7606: add missin=
g datasheet link
  new message: 20240628-cleanup-ad7606-v2-10-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-10-96e02f90256d@baylibre.c=
om
  new message: 202406191142.rs8moLqC-lkp@intel.com
  skipping reply without trailers: 202406191142.rs8moLqC-lkp@intel.com
  new message: 171985436896.136027.10830474139479480832.robh@kernel.org
  found a cover letter for dt-bindings: iio: adc: adi,ad7606: improve descr=
iptions
  found matching patch-id for dt-bindings: iio: adc: adi,ad7606: improve de=
scriptions
  new message: 20240623164920.48dda649@jic23-huawei
  skipping reply without trailers: 20240623164920.48dda649@jic23-huawei
  new message: 20240618-cleanup-ad7606-v1-8-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-8-f1854d5c779d@baylibre.com
  new message: 171872601308.2592859.9209680647249959738.robh@kernel.org
  skipping reply without trailers: 171872601308.2592859.9209680647249959738=
.robh@kernel.org
  new message: 20240618-cleanup-ad7606-v1-3-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-3-f1854d5c779d@baylibre.com
  new message: 20240628-cleanup-ad7606-v2-1-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-1-96e02f90256d@baylibre.com
  new message: 20240618-spearfish-swear-213166c7224f@spud
  skipping parent without a diff or diffstat
  skipping parent without a diff or diffstat
  found matching patch-id for dt-bindings: iio: adc: adi,ad7606: add supply=
 properties
  new message: 62dadd31-5fd1-45b4-99e8-44ffb367bad5@baylibre.com
  skipping reply without trailers: 62dadd31-5fd1-45b4-99e8-44ffb367bad5@bay=
libre.com
  new message: 20240628-cleanup-ad7606-v2-6-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-6-96e02f90256d@baylibre.com
  new message: 20240628-cleanup-ad7606-v2-5-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-5-96e02f90256d@baylibre.com
  new message: 20240618-cleanup-ad7606-v1-9-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-9-f1854d5c779d@baylibre.com
  new message: 20240629163659.322954c3@jic23-huawei
  skipping reply without trailers: 20240629163659.322954c3@jic23-huawei
  new message: 20240629163845.0a8ed683@jic23-huawei
  skipping reply without trailers: 20240629163845.0a8ed683@jic23-huawei
  new message: 20240628-cleanup-ad7606-v2-3-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-3-96e02f90256d@baylibre.com
  new message: 20240628-trustful-urchin-741943d2e98d@spud
  skipping reply without trailers: 20240628-trustful-urchin-741943d2e98d@sp=
ud
  new message: 20240618-rack-synthetic-1d1747b34a6a@spud
  found matching patch-id for dt-bindings: iio: adc: adi,ad7606: fix example
  new message: 20240623162827.45220840@jic23-huawei
  skipping reply without trailers: 20240623162827.45220840@jic23-huawei
  new message: 20240618-cleanup-ad7606-v1-2-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-2-f1854d5c779d@baylibre.com
  new message: 20240628-cleanup-ad7606-v2-8-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-8-96e02f90256d@baylibre.com
  new message: 171952032004.478307.5280182877867747227.robh@kernel.org
  found matching patch-id for dt-bindings: iio: adc: adi,ad7606: comment an=
d sort the compatible names
  new message: 20240623163330.7a9fd911@jic23-huawei
  skipping reply without trailers: 20240623163330.7a9fd911@jic23-huawei
  new message: 20240629161808.6c15bcb9@jic23-huawei
  skipping reply without trailers: 20240629161808.6c15bcb9@jic23-huawei
  new message: 20240629163043.5e96e80c@jic23-huawei
  skipping reply without trailers: 20240629163043.5e96e80c@jic23-huawei
  new message: 20240628-cleanup-ad7606-v2-4-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-4-96e02f90256d@baylibre.com
  new message: 20240623164542.53a9f2b1@jic23-huawei
  skipping reply without trailers: 20240623164542.53a9f2b1@jic23-huawei
  new message: 20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-0-96e02f90256d@baylibre.com
  new message: 20240618-eggnog-cusp-8b5a17313367@spud
  skipping reply without trailers: 20240618-eggnog-cusp-8b5a17313367@spud
  new message: 20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-5-f1854d5c779d@baylibre.com
  new message: 20240629162907.0f5b234e@jic23-huawei
  skipping reply without trailers: 20240629162907.0f5b234e@jic23-huawei
  new message: 20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com
  skipping non-reply: 20240618-cleanup-ad7606-v1-0-f1854d5c779d@baylibre.com
  new message: 20240628-cleanup-ad7606-v2-2-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-2-96e02f90256d@baylibre.com
  new message: 20240628-cleanup-ad7606-v2-9-96e02f90256d@baylibre.com
  skipping non-reply: 20240628-cleanup-ad7606-v2-9-96e02f90256d@baylibre.com
Analyzing follow-up: Re: [PATCH v3 6/8] iio: adc: ad7606: fix oversampling =
gpio array (noname.nuno@gmail.com)
fmsg.in_reply_to=3D20240702-cleanup-ad7606-v3-6-57fd02a4e2aa@baylibre.com
Found in-reply-to 20240702-cleanup-ad7606-v3-6-57fd02a4e2aa@baylibre.com in=
 msgid_map
trailer did not match: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
 Parent: [PATCH v3 6/8] iio: adc: ad7606: fix oversampling gpio array
 Trailers:
Analyzing follow-up: Re: [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio =
state to match the documentation (noname.nuno@gmail.com)
fmsg.in_reply_to=3D20240702-cleanup-ad7606-v3-7-57fd02a4e2aa@baylibre.com
Found in-reply-to 20240702-cleanup-ad7606-v3-7-57fd02a4e2aa@baylibre.com in=
 msgid_map
trailer did not match: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
 Parent: [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio state to match t=
he documentation
 Trailers:
Analyzing follow-up: Re: [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to=
 scoped_guard (noname.nuno@gmail.com)
fmsg.in_reply_to=3D20240702-cleanup-ad7606-v3-8-57fd02a4e2aa@baylibre.com
Found in-reply-to 20240702-cleanup-ad7606-v3-8-57fd02a4e2aa@baylibre.com in=
 msgid_map
trailer did not match: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
 Parent: [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to scoped_guard
 Trailers:
Analyzing follow-up: Re: [PATCH v3 0/8] iio: adc: ad7606: Improvements (jic=
23@kernel.org)
  no trailers found, skipping
Analyzing follow-up: Re: [PATCH v3 0/8] iio: adc: ad7606: Improvements (kon=
stantin@linuxfoundation.org)
  no trailers found, skipping
Analyzing follow-up: Re: [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to=
 scoped_guard (Markus.Elfring@web.de)
  no trailers found, skipping
  trailer email match
    adding "Acked-by: Rob Herring (Arm) <robh@kernel.org>" from trailer_map=
 to: [PATCH v3 1/8] dt-bindings: iio: adc: adi,ad7606: normalize textwidth
  trailer exact name match
  trailer fuzzy name match
    adding "Reviewed-by: Conor Dooley <conor.dooley@microchip.com>" from tr=
ailer_map to: [PATCH v3 1/8] dt-bindings: iio: adc: adi,ad7606: normalize t=
extwidth
  trailer email match
    adding "Reviewed-by: Rob Herring (Arm) <robh@kernel.org>" from trailer_=
map to: [PATCH v3 1/8] dt-bindings: iio: adc: adi,ad7606: normalize textwid=
th
  trailer exact name match
  trailer fuzzy name match
    adding "Reviewed-by: Conor Dooley <conor.dooley@microchip.com>" from tr=
ailer_map to: [PATCH v3 4/8] dt-bindings: iio: adc: adi,ad7606: fix example
  trailer exact name match
  trailer fuzzy name match
  trailer email match
    adding "Reviewed-by: Rob Herring (Arm) <robh@kernel.org>" from trailer_=
map to: [PATCH v3 4/8] dt-bindings: iio: adc: adi,ad7606: fix example
  trailer exact name match
  trailer fuzzy name match
    adding "Acked-by: Conor Dooley <conor.dooley@microchip.com>" from trail=
er_map to: [PATCH v3 4/8] dt-bindings: iio: adc: adi,ad7606: fix example
  trailer exact name match
  trailer fuzzy name match
    adding "Reviewed-by: Conor Dooley <conor.dooley@microchip.com>" from tr=
ailer_map to: [PATCH v3 5/8] dt-bindings: iio: adc: adi,ad7606: add conditi=
ons
  trailer email match
    adding "Reviewed-by: Rob Herring (Arm) <robh@kernel.org>" from trailer_=
map to: [PATCH v3 5/8] dt-bindings: iio: adc: adi,ad7606: add conditions
  trailer exact name match
  trailer fuzzy name match
    adding "Reviewed-by: Conor Dooley <conor.dooley@microchip.com>" from tr=
ailer_map to: [PATCH v3 6/8] iio: adc: ad7606: fix oversampling gpio array
  trailer exact name match
  trailer fuzzy name match
  trailer email match
    adding "Reviewed-by: Rob Herring (Arm) <robh@kernel.org>" from trailer_=
map to: [PATCH v3 6/8] iio: adc: ad7606: fix oversampling gpio array
  trailer exact name match
  trailer fuzzy name match
    adding "Reviewed-by: Conor Dooley <conor.dooley@microchip.com>" from tr=
ailer_map to: [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio state to ma=
tch the documentation
  trailer exact name match
  trailer fuzzy name match
  trailer email match
    adding "Reviewed-by: Rob Herring (Arm) <robh@kernel.org>" from trailer_=
map to: [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio state to match th=
e documentation
Checking attestation on all messages, may take a moment...
Loading attestation: [PATCH v3 1/8] dt-bindings: iio: adc: adi,ad7606: norm=
alize textwidth
Loading DKIM attestation for d=3Dbaylibre-com.20230601.gappssmtp.com, s=3D2=
0230601
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/relaxed', b'd'=
: b'baylibre-com.20230601.gappssmtp.com', b's': b'20230601', b't': b'171994=
1647', b'x': b'1720546447', b'darn': b'vger.kernel.org', b'h': b'cc:to:in-r=
eply-to:references:message-id:content-transfer-encoding\r\n         :mime-v=
ersion:subject:date:from:from:to:cc:subject:date:message-id\r\n         :re=
ply-to', b'bh': b'XoOP6xDFVO+piNQMxKh2JgMUAWvA+ZCbwk4Ckp0ym3U=3D', b'b': b'=
bskrnKu86JUiCpGnSMMH0jp0oIo7CNOU5GucJkH1i8FNuWfuWtgReLxPKvsgakZwwe\r\n     =
    zeCBNMxG4Ev5grxV0bx9i2Dj/w9ZHSLvHRN4Sx6nKXjNT1vKIHb0cSCBedtTb7KneORE\r\=
n         F6VzDlGwGBBYugqJT1xtmsuSbUR5ujVM8dIlADMkhlqoJY+77P59vry8d5kiW/SNt=
MID\r\n         Ejgdd2Gt2ocgc9+W/bypD9KGWg10oIlrxxuS4PB30iEIi2fUsm8tiwnhnBm=
8RToMKs7r\r\n         ZBKEyyxjJLJgzsbDytQli+8g7Uxdk029u1WEmmfi18xEZD8PQ7xXG=
gf4umta217DkiV0\r\n         WL1Q=3D=3D'}
DKIM: bh: b'XoOP6xDFVO+piNQMxKh2JgMUAWvA+ZCbwk4Ckp0ym3U=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: baylibre-com.20230601.gappssmtp.com=3DTrue
Attestors: 1
PASS : time drift between Date and t (0:00:02)
Loading attestation: [PATCH v3 2/8] dt-bindings: iio: adc: adi,ad7606: impr=
ove descriptions
Loading DKIM attestation for d=3Dbaylibre-com.20230601.gappssmtp.com, s=3D2=
0230601
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/relaxed', b'd'=
: b'baylibre-com.20230601.gappssmtp.com', b's': b'20230601', b't': b'171994=
1648', b'x': b'1720546448', b'darn': b'vger.kernel.org', b'h': b'cc:to:in-r=
eply-to:references:message-id:content-transfer-encoding\r\n         :mime-v=
ersion:subject:date:from:from:to:cc:subject:date:message-id\r\n         :re=
ply-to', b'bh': b'HiVIhZEAyuYnJTbH9Xr5ihUjZSz2ff/4WqtLGIZJN0k=3D', b'b': b'=
JVOkIvJ+wPM4x7f1DiLk5FgH7P2fdCOFd5yG0hQ1yWyFJA0zhdVyeV6NbX92z8gSWv\r\n     =
    KVb7rxfScYJQTBbv5mE2ykov//i1aNLabqEJzgkCF7mR9a/mRs7p1wZg+9l8mWvvwbAr\r\=
n         Ssg68/Yjzo0ra30+fc/Hpko9ZhURiLXswyNcHMWWErQLN4G68FQYmsBFvt3y+YTNl=
7hd\r\n         0ToQ6lMQjcB1fgdtCHqemj5uJuZhsaco8ZFZd8TNCEwLKUhYdMW596nBuc/=
koIG1bOeB\r\n         x78KtxccdXiqugLGGpP5G9JgHnI2/9lDsOOBjSA4jDiCT4BYD5JlD=
+JiMvDYW9Gtbn77\r\n         jzEw=3D=3D'}
DKIM: bh: b'HiVIhZEAyuYnJTbH9Xr5ihUjZSz2ff/4WqtLGIZJN0k=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: baylibre-com.20230601.gappssmtp.com=3DTrue
Attestors: 1
PASS : time drift between Date and t (0:00:02)
Loading attestation: [PATCH v3 3/8] dt-bindings: iio: adc: adi,ad7606: add =
supply properties
Loading DKIM attestation for d=3Dbaylibre-com.20230601.gappssmtp.com, s=3D2=
0230601
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/relaxed', b'd'=
: b'baylibre-com.20230601.gappssmtp.com', b's': b'20230601', b't': b'171994=
1648', b'x': b'1720546448', b'darn': b'vger.kernel.org', b'h': b'cc:to:in-r=
eply-to:references:message-id:content-transfer-encoding\r\n         :mime-v=
ersion:subject:date:from:from:to:cc:subject:date:message-id\r\n         :re=
ply-to', b'bh': b'W4PsgI6ViSPMjJzEXz9ZwZPETs75x12HxOOvUnLBogs=3D', b'b': b'=
MMQfxXhxHILGpuIKp7BXBARHk67TYPEtouN+SIQNb/okU9lwCsaVwPUui8IJdSAnwq\r\n     =
    eELlxHmR7iXrka7txLZRSn4LI9QY+6s3uf7QoQicsEjT8zkdWIKf7Y5R3oGsWyMIhgDW\r\=
n         NOdTRaM/dyhHjsDtVv6JTsl1HPbeBA5ilCvMN4hSenQ3nPqjZR9JC9Vg6fCJ+ydiR=
5fs\r\n         B3Xbyskyg5ffV8ONLy1CuWbsLLm89Md/CgQ8tSxYhgl8Kocmi/9xWyMjbKk=
c7hiZbiss\r\n         GjNj8dxHP2FtztI9SQLm54lmwW8KGpUbxQqnaFFHm4qMxC9EaEx5g=
CFD7grgZxyqYiv/\r\n         NdfQ=3D=3D'}
DKIM: bh: b'W4PsgI6ViSPMjJzEXz9ZwZPETs75x12HxOOvUnLBogs=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: baylibre-com.20230601.gappssmtp.com=3DTrue
Attestors: 1
PASS : time drift between Date and t (0:00:01)
Loading attestation: [PATCH v3 4/8] dt-bindings: iio: adc: adi,ad7606: fix =
example
Loading DKIM attestation for d=3Dbaylibre-com.20230601.gappssmtp.com, s=3D2=
0230601
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/relaxed', b'd'=
: b'baylibre-com.20230601.gappssmtp.com', b's': b'20230601', b't': b'171994=
1649', b'x': b'1720546449', b'darn': b'vger.kernel.org', b'h': b'cc:to:in-r=
eply-to:references:message-id:content-transfer-encoding\r\n         :mime-v=
ersion:subject:date:from:from:to:cc:subject:date:message-id\r\n         :re=
ply-to', b'bh': b'bqVxrCmaqTdd1OivUsUaCiiNGBxmmQjkW28fKPO8hWM=3D', b'b': b'=
X9OwpT/GOyRvGYNRAocpe5BorQ35LZ8cPEWEfpTR6VVmG/PAiBclZWeABUcaqBY7qh\r\n     =
    LDPrH3wmj2M9egaLNVE0QXywMfeRljb3nFTSSHVEA2Fq6BttdiEj5Wg1LvIhwsPo3FQN\r\=
n         YSjl8QJTLn5CachTFU1FE9zAyxIYewQNASAbijE5rrbCTLor6iymiVQlZGI3yH81+=
hre\r\n         hmhcxSoPQ6mjcnmwbRKMq9gwBFiRFv6XD3dcXiah3zLKRFZiNea74dhik8S=
2mz6Ho3lL\r\n         t4WG2pmXB7JXCj9SJxI9Vc/mfFhv7GyeVtS+zPSNqggUVVSPskvwE=
tL0EMutxK6dI13F\r\n         TPZg=3D=3D'}
DKIM: bh: b'bqVxrCmaqTdd1OivUsUaCiiNGBxmmQjkW28fKPO8hWM=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: baylibre-com.20230601.gappssmtp.com=3DTrue
Attestors: 1
PASS : time drift between Date and t (0:00:01)
Loading attestation: [PATCH v3 5/8] dt-bindings: iio: adc: adi,ad7606: add =
conditions
Loading DKIM attestation for d=3Dbaylibre-com.20230601.gappssmtp.com, s=3D2=
0230601
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/relaxed', b'd'=
: b'baylibre-com.20230601.gappssmtp.com', b's': b'20230601', b't': b'171994=
1649', b'x': b'1720546449', b'darn': b'vger.kernel.org', b'h': b'cc:to:in-r=
eply-to:references:message-id:content-transfer-encoding\r\n         :mime-v=
ersion:subject:date:from:from:to:cc:subject:date:message-id\r\n         :re=
ply-to', b'bh': b'OlOMVM0Oi/I1G5ABSh4CvVIoiZHYlhaelZAr8Gl3RX4=3D', b'b': b'=
Tb2/hbh25bo/t5+n3AURyKbt8RCGLirlj9Dzhx3WRbY6Rf+9SPAc3FH73mXmDXjc0r\r\n     =
    oecveLKmgKuQw/9hNnyGi3S8L3W5Pl1wLMFYIssGi0QiqdTx/Sd2nib8Fx1In2mmZEsX\r\=
n         sTf/I2R1uYfqUD5y8rktm73lE4yBU30TQmo7sEO8s5TYZH1Uwb4+5dzNJ8sMd4RwX=
Gcq\r\n         l9+7mQd1CAiNBGxZjte/NKmjepAXvKOk6Zv2biaaN7SQyReGZnQENMVNFAW=
ySePshDyN\r\n         GC7BBHxwts+6IJ5bqdtKCMMLLyNhx3yziQS5JJQ/Qk5WIGRSX6Yvx=
jfehsrHOQ5BqcMW\r\n         VatQ=3D=3D'}
DKIM: bh: b'OlOMVM0Oi/I1G5ABSh4CvVIoiZHYlhaelZAr8Gl3RX4=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: baylibre-com.20230601.gappssmtp.com=3DTrue
Attestors: 1
PASS : time drift between Date and t (0:00:00)
Loading attestation: [PATCH v3 6/8] iio: adc: ad7606: fix oversampling gpio=
 array
Loading DKIM attestation for d=3Dbaylibre-com.20230601.gappssmtp.com, s=3D2=
0230601
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/relaxed', b'd'=
: b'baylibre-com.20230601.gappssmtp.com', b's': b'20230601', b't': b'171994=
1650', b'x': b'1720546450', b'darn': b'vger.kernel.org', b'h': b'cc:to:in-r=
eply-to:references:message-id:content-transfer-encoding\r\n         :mime-v=
ersion:subject:date:from:from:to:cc:subject:date:message-id\r\n         :re=
ply-to', b'bh': b'iYOb3cXloM7JPnPejGsCNHK/CDwXTFwHzLHb3/a7qrs=3D', b'b': b'=
svL4kTXcPOQ9HPCJ3Xp0NAJEsOuZVPfLRyOAMLjPjEaUjFowOymTlyXzxtdSE4+pQ2\r\n     =
    XFfjnZSuNjeoiP4z6JQExroqoVw1VCkW1sb+A41j8cTp17lN5LaM9oY8zEdBiLA+xov7\r\=
n         LcgwmBWgQKXaEm+zHRwsTpBXVcLaRmMmlc/tLo4Y77a9FVLYJDSQLOJwPDFBTlfTP=
MCa\r\n         UK8IWdqXS/+zUWQXXjPiNObYDFcUl/Tfnsx6dnyrZhiLl4ySc73QtT4j5/1=
wnkpSBCrY\r\n         NelVVL/dWhhd1AhsABv9fMBhGBc1BqovDozxd1OS/0GOunqEU802F=
HzfDHHa96O5uDzO\r\n         t2dA=3D=3D'}
DKIM: bh: b'iYOb3cXloM7JPnPejGsCNHK/CDwXTFwHzLHb3/a7qrs=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: baylibre-com.20230601.gappssmtp.com=3DTrue
Attestors: 1
PASS : time drift between Date and t (0:00:00)
Loading attestation: [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio stat=
e to match the documentation
Loading DKIM attestation for d=3Dbaylibre-com.20230601.gappssmtp.com, s=3D2=
0230601
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/relaxed', b'd'=
: b'baylibre-com.20230601.gappssmtp.com', b's': b'20230601', b't': b'171994=
1650', b'x': b'1720546450', b'darn': b'vger.kernel.org', b'h': b'cc:to:in-r=
eply-to:references:message-id:content-transfer-encoding\r\n         :mime-v=
ersion:subject:date:from:from:to:cc:subject:date:message-id\r\n         :re=
ply-to', b'bh': b'0syamWwYKEIgGFfBRP6mPS2Iu9QxWFGeekc+8eB0dRA=3D', b'b': b'=
f04+9I1Zp3cuLVlh/iAyzqvyLqR/68uCE60iStM+7uiaA+NyLfEIhUU/fBEOK5ahv9\r\n     =
    W5+qEKQMAGz/8TAzWesVAKfHURcOsU7/4EI79CGAKDVsLbK4sFiuQ4dofCfXafxeFlul\r\=
n         V8uTBRmqvkYu2dqTJLQvF1K7REeYy0oFREGAzcwdrf7EgM29goqFrq5pr1WyPTwkd=
cD6\r\n         n7ijdi3EdUM+RDW2MaQ4QQqt0Ne5eD1XrPOTBcnHD/8ysSZenDYfb7WlBnV=
kj8qJ7uBm\r\n         r5kODm7INJp8Tep99c2QJzme64wh1O+bsN33Izg3hdakNMh5Agcvf=
VblmgqQ+C+/M6gb\r\n         U5+Q=3D=3D'}
DKIM: bh: b'0syamWwYKEIgGFfBRP6mPS2Iu9QxWFGeekc+8eB0dRA=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: baylibre-com.20230601.gappssmtp.com=3DTrue
Attestors: 1
PASS : time drift between Date and t (-1 day, 23:59:59)
Loading attestation: [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to sco=
ped_guard
Loading DKIM attestation for d=3Dbaylibre-com.20230601.gappssmtp.com, s=3D2=
0230601
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/relaxed', b'd'=
: b'baylibre-com.20230601.gappssmtp.com', b's': b'20230601', b't': b'171994=
1651', b'x': b'1720546451', b'darn': b'vger.kernel.org', b'h': b'cc:to:in-r=
eply-to:references:message-id:content-transfer-encoding\r\n         :mime-v=
ersion:subject:date:from:from:to:cc:subject:date:message-id\r\n         :re=
ply-to', b'bh': b'E8NfF8jZGHkcRRoEHwh26DQAMmLR92lEfTyFLVBd7mk=3D', b'b': b'=
wjgEClSKZUgLm+5X2uffIcPZ8XKSVrPa9StW/UaOK5HuR6isRw6VJz5Abx/rf50QAK\r\n     =
    kXoyWi3gZXDLrOqoXcGEVlQADzT5gdleupF0ljteP8kq3rDZuTH8zQphgZd1z3BvunqE\r\=
n         amG4Najj73fS73XTLLMMnVCA0nDi+RXZ82kYZDtzRelT5ljnj9cVx3pC2d5/EhEm5=
N4n\r\n         saRx1qzD+F0MB2TwYFKRfia3C618gHwpIsLwWzJW41EjofybfJNFG1TYpFz=
I8yr9LsC2\r\n         oPGOhUyASfS+bYAyBzQ1P38qh+ni12suKkDrOHDSdrZ+kJ/0UNmx2=
bBUMiQ16vnxJ97j\r\n         FiPA=3D=3D'}
DKIM: bh: b'E8NfF8jZGHkcRRoEHwh26DQAMmLR92lEfTyFLVBd7mk=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: baylibre-com.20230601.gappssmtp.com=3DTrue
Attestors: 1
PASS : time drift between Date and t (-1 day, 23:59:59)
---
  =1B[32m=E2=9C=93=1B[0m [PATCH v3 1/8] dt-bindings: iio: adc: adi,ad7606: =
normalize textwidth
Body contains non-ascii characters. Running Unicode Cf char tests.
Running git --no-pager mailinfo --encoding=3DUTF-8 --scissors /tmp/tmpzcodv=
utk/m /tmp/tmpzcodvutk/p
Loading attestation: Re: [PATCH v2 07/10] dt-bindings: iio: adc: adi,ad7606=
: add conditions
Loading DKIM attestation for d=3Dkernel.org, s=3Dk20201202
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/simple', b'd':=
 b'kernel.org', b's': b'k20201202', b't': b'1719587717', b'bh': b'bu0ftpyAi=
juweDhRTmvWJVpSDGx2EDgXAxaHL4ijmww=3D', b'h': b'Date:From:To:Cc:Subject:Ref=
erences:In-Reply-To:From', b'b': b'sJf6Few/SMza311Oz8Dt5No3XiJ94XiQWAasODCy=
bdXBiSeYvzAQlejnBa1Lato5U\r\n\t wyG5175CnhPJqSxeIQ4zw+MjsyidmYSmnGjSefsTbqX=
U+jgjx80Wq99amKuWLsyb3y\r\n\t sLqmVURhq4h1hUOVoA0w10ibFAEBciW1t5MIPGBYrBrNQ=
I6DivjGg/VNHW1/ag6i3T\r\n\t IYKSCrRPCE7moJNURIlvC/3aBPQtVxe7onVmb1SIQ3t1o9L=
z8ziKQThZdD6KgQHLBT\r\n\t 5IsYpjJOsLaMI2D0zXH5RvL+lfV7LOjCIC8R2avOqMX6SHf2I=
H3JPrkurxMUYdVV2I\r\n\t vGQQG9lKR8L+A=3D=3D'}
DKIM: bh: b'bu0ftpyAijuweDhRTmvWJVpSDGx2EDgXAxaHL4ijmww=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: kernel.org=3DTrue
PASS : sig domain kernel.org matches from identity conor@kernel.org
Attestors: 1
    + Reviewed-by: Conor Dooley <conor.dooley@microchip.com> (=1B[32m=E2=9C=
=93=1B[0m DKIM/kernel.org)
Loading attestation: Re: [PATCH v2 04/10] dt-bindings: iio: adc: adi,ad7606=
: improve descriptions
Loading DKIM attestation for d=3Dkernel.org, s=3Dk20201202
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/simple', b'd':=
 b'kernel.org', b's': b'k20201202', b't': b'1719854370', b'bh': b'F6Mg3Q9Ht=
FWN3btjP5ziRej2VlTPFVg4j6vn1JweSfI=3D', b'h': b'Date:From:To:Cc:Subject:Ref=
erences:In-Reply-To:From', b'b': b'SHx7u0vLf+kFXkUaPhxUr8J78oY6ddSvwzn4tjHa=
O8qiAeZxuucFdRm2vDrZOO8T/\r\n\t MzL6oKjXa7TXAio2yY8E4j255UKeljiSIW91xWHq2iK=
YSyKPd+/HQlsBw6CkrGkrW4\r\n\t r847M5mE+gZH1TBnO4e79zptI8uxQ6DMyyJ4oUvEHdlCE=
EEZ8/3FOOCyNVJJSo/Fui\r\n\t J35ZkXzk3JMINehehfZdv3C5Hi9PzpGxocXfKB9ATBLm2LJ=
VZK4Ya1D1IJjy7p1tuk\r\n\t qJEp9eHbZulMa6TTWvEHi/3ggMbjOjR6Uk6j5zdzemeUfZ/mF=
XLl01BCl75YZrTlNh\r\n\t pAxKYhOpNhVow=3D=3D'}
DKIM: bh: b'F6Mg3Q9HtFWN3btjP5ziRej2VlTPFVg4j6vn1JweSfI=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: kernel.org=3DTrue
PASS : sig domain kernel.org matches from identity robh@kernel.org
Attestors: 1
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=1B[32m=E2=9C=93=1B=
[0m DKIM/kernel.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-1-57fd02a4e=
2aa@baylibre.com
  =1B[32m=E2=9C=93=1B[0m [PATCH v3 2/8] dt-bindings: iio: adc: adi,ad7606: =
improve descriptions
Body contains non-ascii characters. Running Unicode Cf char tests.
Running git --no-pager mailinfo --encoding=3DUTF-8 --scissors /tmp/tmphavue=
hp5/m /tmp/tmphavuehp5/p
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-2-57fd02a4e=
2aa@baylibre.com
  =1B[32m=E2=9C=93=1B[0m [PATCH v3 3/8] dt-bindings: iio: adc: adi,ad7606: =
add supply properties
Running git --no-pager mailinfo --encoding=3DUTF-8 --scissors /tmp/tmp3_24h=
10k/m /tmp/tmp3_24h10k/p
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-3-57fd02a4e=
2aa@baylibre.com
  =1B[32m=E2=9C=93=1B[0m [PATCH v3 4/8] dt-bindings: iio: adc: adi,ad7606: =
fix example
Running git --no-pager mailinfo --encoding=3DUTF-8 --scissors /tmp/tmpcy04x=
gt3/m /tmp/tmpcy04xgt3/p
Loading attestation: Re: [PATCH 5/9] dt-bindings: iio: adc: adi,ad7606: add=
 conditions
Loading DKIM attestation for d=3Dkernel.org, s=3Dk20201202
DKIM: sig: {b'v': b'1', b'a': b'rsa-sha256', b'c': b'relaxed/simple', b'd':=
 b'kernel.org', b's': b'k20201202', b't': b'1718723637', b'bh': b'kWLzasd2J=
v00eh2+ymMa0JXWplIZ46GqFdb45PLJiMs=3D', b'h': b'Date:From:To:Cc:Subject:Ref=
erences:In-Reply-To:From', b'b': b'JHP2taepLHd1qo2ZO3Fqo5kv42Y7HWK3Hvd4M9y2=
nQyamYsR5YFzzeg2qxzZaGeZB\r\n\t 7ZdRPOggnESPB72uGTfHtxrMYHUu9VivKEp62sFDgqw=
7t40OShbPhAyEmDwSujTM8L\r\n\t jlpJkJIwACiMEUKiXkgrJQS2ImsfaBlG+vo6JUZgmmw/l=
V7Tg1gZIUY4HFTjPIb/Xu\r\n\t UntfmSZN5WNXqR1Es9Jto/136eADuj73gdLn4T7FL3k9ui8=
XrhCxUm86sueii4+W/r\r\n\t 4Va9iKPlphFGvUY/fnde6a6Ahqk1mQxQRXUSHs0ZoEeLJo/Ff=
hR8SRt6a7bbMF/DSc\r\n\t Cfl1P7hqIRE+g=3D=3D'}
DKIM: bh: b'kWLzasd2Jv00eh2+ymMa0JXWplIZ46GqFdb45PLJiMs=3D'
DKIM: b'DKIM-Signature' valid: True
DKIM verify results: kernel.org=3DTrue
PASS : sig domain kernel.org matches from identity conor@kernel.org
Attestors: 1
    + Reviewed-by: Conor Dooley <conor.dooley@microchip.com> (=1B[32m=E2=9C=
=93=1B[0m DKIM/kernel.org)
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=1B[32m=E2=9C=93=1B=
[0m DKIM/kernel.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-4-57fd02a4e=
2aa@baylibre.com
  =1B[32m=E2=9C=93=1B[0m [PATCH v3 5/8] dt-bindings: iio: adc: adi,ad7606: =
add conditions
Body contains non-ascii characters. Running Unicode Cf char tests.
Running git --no-pager mailinfo --encoding=3DUTF-8 --scissors /tmp/tmpdbsjb=
qe5/m /tmp/tmpdbsjbqe5/p
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=1B[32m=E2=9C=93=1B=
[0m DKIM/kernel.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-5-57fd02a4e=
2aa@baylibre.com
  =1B[32m=E2=9C=93=1B[0m [PATCH v3 6/8] iio: adc: ad7606: fix oversampling =
gpio array
Running git --no-pager mailinfo --encoding=3DUTF-8 --scissors /tmp/tmp07w7v=
2eu/m /tmp/tmp07w7v2eu/p
    + Reviewed-by: Conor Dooley <conor.dooley@microchip.com> (=1B[32m=E2=9C=
=93=1B[0m DKIM/kernel.org)
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=1B[32m=E2=9C=93=1B=
[0m DKIM/kernel.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-6-57fd02a4e=
2aa@baylibre.com
  =1B[32m=E2=9C=93=1B[0m [PATCH v3 7/8] iio: adc: ad7606: fix standby gpio =
state to match the documentation
Running git --no-pager mailinfo --encoding=3DUTF-8 --scissors /tmp/tmparf0x=
uvu/m /tmp/tmparf0xuvu/p
    + Reviewed-by: Conor Dooley <conor.dooley@microchip.com> (=1B[32m=E2=9C=
=93=1B[0m DKIM/kernel.org)
    + Reviewed-by: Rob Herring (Arm) <robh@kernel.org> (=1B[32m=E2=9C=93=1B=
[0m DKIM/kernel.org)
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-7-57fd02a4e=
2aa@baylibre.com
  =1B[32m=E2=9C=93=1B[0m [PATCH v3 8/8] iio: adc: ad7606: switch mutexes to=
 scoped_guard
Running git --no-pager mailinfo --encoding=3DUTF-8 --scissors /tmp/tmpypnbw=
tkn/m /tmp/tmpypnbwtkn/p
    + Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-8-57fd02a4e=
2aa@baylibre.com
  ---
  =1B[32m=E2=9C=93=1B[0m Signed: DKIM/baylibre-com.20230601.gappssmtp.com (=
From: gstols@baylibre.com)
---
Total patches: 8
---
NOTE: some trailers ignored due to from/email mismatches:
    ! Trailer: Reviewed-by: Nuno Sa <nuno.sa@analog.com>
     Msg From: Nuno S=C3=A1 <noname.nuno@gmail.com>
NOTE: Rerun with -S to apply them anyway
Running git --no-pager rev-parse --show-toplevel
---
Running git --no-pager mailinfo --encoding=3DUTF-8 --scissors /tmp/tmpnzax6=
wah/m /tmp/tmpnzax6wah/p
Cover: ./v3_20240702_gstols_iio_adc_ad7606_improvements.cover
 Link: https://patch.msgid.link/20240702-cleanup-ad7606-v3-0-57fd02a4e2aa@b=
aylibre.com
Running git --no-pager --git-dir /home/jic23/src/kernel/iio/.git cat-file -=
e 340fa834ae229a952db04a57ed13fd5d35d75818
 Base: using specified base-commit 340fa834ae229a952db04a57ed13fd5d35d75818
       git checkout -b v3_20240702_gstols_baylibre_com 340fa834ae229a952db0=
4a57ed13fd5d35d75818
       git am ./v3_20240702_gstols_iio_adc_ad7606_improvements.mbx
Wrote v3_20240702_gstols_iio_adc_ad7606_improvements.am for thanks tracking


>=20
> -K


