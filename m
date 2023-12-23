Return-Path: <linux-iio+bounces-1232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1A81D334
	for <lists+linux-iio@lfdr.de>; Sat, 23 Dec 2023 09:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18D70B22092
	for <lists+linux-iio@lfdr.de>; Sat, 23 Dec 2023 08:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401818C07;
	Sat, 23 Dec 2023 08:40:09 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547278BEC;
	Sat, 23 Dec 2023 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rGx9J-0005AO-V1; Sat, 23 Dec 2023 09:14:22 +0100
Message-ID: <a59faf48-2a8a-41ce-8d59-b65a7cdfdf17@leemhuis.info>
Date: Sat, 23 Dec 2023 09:14:31 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Support light color temperature and chromaticity
Content-Language: en-US, de-DE
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, jic23@kernel.org,
 lars@metafoo.de, srinivas.pandruvada@linux.intel.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 regressions@lists.linux.dev
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
 <4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1703320807;74558ded;
X-HE-SMSGID: 1rGx9J-0005AO-V1

[TLDR: This mail in primarily relevant for Linux regression tracking. A
change or fix related to the regression discussed in this thread was
posted or applied, but it did not use a Closes: tag to point to the
report, as Linus and the documentation call for. Things happen, no
worries -- but now the regression tracking bot needs to be told manually
about the fix. See link in footer if these mails annoy you.]

On 07.12.23 00:39, Thomas Weißschuh wrote:
> On 2023-09-19 13:40:45+0530, Basavaraj Natikar wrote:
> [...]
> This series is breaking probing of hid-sensor-als on Framework 13 AMD
> laptops [0].
> [...]
> #regzbot introduced: 5f05285df691b1e82108eead7165feae238c95ef
> #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=218223

#regzbot fix: d4005431673929
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.



