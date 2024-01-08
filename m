Return-Path: <linux-iio+bounces-1504-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F38827A22
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 22:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9D2284421
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 21:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEEA55E73;
	Mon,  8 Jan 2024 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="K9e3q21P"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DA255E78;
	Mon,  8 Jan 2024 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Mx4BrfC5g9WXyMx4Brfpu9; Mon, 08 Jan 2024 22:21:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1704748912;
	bh=2p9Q+jAWJlplhGc07QfrKCznJ+mNJq4HzpKxzFx9wCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=K9e3q21Psil2drFZxG1oIw7zq7fSItXP6z7fiV0vO1jwNJ/pj14oc+2oZUfpa+u3g
	 o0kJP20IKzV1FES0HLUq2B33DVq0oPRzHBNHUc8UAOhutxmXIpRm36HO+Z2fjtTNo8
	 /v30NbI7ScRtjtilQNUyTQFYrUjAAp2pp/LwXZyHYmRlAnMfrg9OshC3CrMHVRN7Oo
	 rGSSawGS7UL2XlwXw/b8aukafec17w/NBhBxPgTCSrVgHi+NIp5hg3UIZgadBDh8jH
	 bqe0R+2haSu7nRp+i7LLtUdR5y9fLl/8S4mnH7lFWE3aIYq0NznkdHKhqi61GnndcI
	 3GW52lvQxd1oQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 08 Jan 2024 22:21:52 +0100
X-ME-IP: 92.140.202.140
Message-ID: <18d2e448-f3d4-4eb2-a54a-9dc9198b7260@wanadoo.fr>
Date: Mon, 8 Jan 2024 22:21:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: correct file entry for AD7091R
Content-Language: fr
To: mechanicalamit@gmail.com
Cc: dan.carpenter@linaro.org, jic23@kernel.org,
 kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org,
 marcelo.schmitt@analog.com
References: <CAO=gReEUr4B+E2mQsSrncHf41f0A915SuoWgA522_2Ts-dZbSg@mail.gmail.com>
 <d537ca6c-180c-4f35-8441-adea03095689@moroto.mountain>
 <CAO=gReHX0+tVzrdceeT=NVkQhRvF1xO73fup-nYjStY2T9x4BA@mail.gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAO=gReHX0+tVzrdceeT=NVkQhRvF1xO73fup-nYjStY2T9x4BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/01/2024 à 22:15, Amit Dhingra a écrit :
> On Mon, Jan 08, 2024 at 10:56:02AM +0300, Dan Carpenter wrote:
>> Generally, patches to MAINTAINERS don't need Fixes tags.
>>
>> It doesn't matter if the patch is in mainline or not.  If it's in a tree
>> which is rebased then maintainers will fold the fix into the original
>> commit and the Fixes tag will be lost.  But that's fine.
> 
> Makes sense. Thank you for the information and guidance.
>>
>> Also when you're using a Fixes tag, it should all go one one line.
>> Don't line wrap it at 75 characters.  Just go over the limit.  That's
>> the normal/correct way.
> Also seems like checkpatch does not like the Fixes line without the
> keyword Commit. So the fixes line below generates an Error.
> 
> Fixes : 7564efb37346 ("MAINTAINERS: Add entry for TQ-Systems device

Hi,
try to remove the space after Fixes (i.e. Fixes: 7564efb37346)

CJ

> trees and drivers")
> 
> ERROR: Please use git commit description style 'commit <12+ chars of
> sha1> ("<title line>")' - ie: 'commit 7564efb37346 ("MAINTAINERS: Add
> entry for TQ-Systems device trees and drivers")'
> 
> Adding the keyword commit gives no error.
> 
> Documentation shows to use the Fixes tag without the keyword commit.
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
> 
>>
>> regards,
>> dan carpenter
>>
> 
> 


