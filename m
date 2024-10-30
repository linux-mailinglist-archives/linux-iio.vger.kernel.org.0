Return-Path: <linux-iio+bounces-11588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2919B5A63
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 04:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEEA1F23AC9
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 03:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56534194094;
	Wed, 30 Oct 2024 03:33:58 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0227615E96;
	Wed, 30 Oct 2024 03:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730259238; cv=none; b=r0TTB4fFrB8iMBANfhf/pK3shHwamo0XZCVI7+uCEHJElfy5Bbdf73et+uHlweuLhNo26w3wbBqJ9I6uqpLqX99m2/Jd9yb7/Gye83UXctRqt3QBk9j7a9ehZh/Dv/C+PS3PMGkwspbSNExmOADhGN6z1QIlKzKDTwiOphO0iC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730259238; c=relaxed/simple;
	bh=DNkyHooScxKqiZxAblfiHf5n/f4JMOfqYz4fdtHRRjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCU008ak3fkAJirotH9HgbqFW+URBU/0Y1iLEXINBCU98hDgZblA6yLGigGEy7cNeZm03Z6ipkZ/H1Iu2G5PIha282eBSN5SVFGhIdyOBlY/eIZOr05Qp47KngK91nbY/ztmsklLvZLodO3WLB8m0TVDKay0aUjI93UONzW4xmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c7049e3a966f11efa216b1d71e6e1362-20241030
X-CTIC-Tags:
	HR_ERR_NO_COLON, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_C_CI, GTI_FG_IT, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:3f8286ce-d28f-486a-8fd0-3072b057f2a6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-INFO: VERSION:1.1.38,REQID:3f8286ce-d28f-486a-8fd0-3072b057f2a6,IP:0,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:-5
X-CID-META: VersionHash:82c5f88,CLOUDID:696fca44f4c6f4130264cb8385afe300,BulkI
	D:2410300456049ZBETGBO,BulkQuantity:1,Recheck:0,SF:64|66|841|38|17|19|102,
	TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:ni
	l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-UUID: c7049e3a966f11efa216b1d71e6e1362-20241030
X-User: xiaopei01@kylinos.cn
Received: from xiaopei-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 875342421; Wed, 30 Oct 2024 11:33:49 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: Markus Elfring <Markus.Elfring@web.de>,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	linux-kernel@vger.kernel.org,
	xiaopeitux@foxmail.com
Subject: Re: [PATCH] iio: test: rescale: check null return of kunit_kmalloc
Date: Wed, 30 Oct 2024 11:33:43 +0800
Message-Id: <5cf3596e-3531-467a-a6a2-315bb0a914c0@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7d4ee76d-ec47-484d-bcd2-2984d1d136f0@web.de>
References: <cceb503f429ae829069709ac476acef77a0e8612.1730191256.git.xiaopei01@kylinos.cn>  <7d4ee76d-ec47-484d-bcd2-2984d1d136f0@web.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
X-Mozilla-Draft-Info: internal/draft; vcard=0; receipt=0; DSN=0; uuencode=0;  attachmentreminder=0; deliveryformat=1
X-Identity-Key: id1
Fcc: imap://xiaopei01%40kylinos.cn@imap.kylinos.cn/Sent
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

=0D
=0D
On 2024/10/30 04:55, Markus Elfring wrote:=0D
>> kunit_kmalloc may fail, return might be NULL and will cause=0D
>> NULL pointer dereference later.=0D
> =0D
> * Please choose an imperative wording for an improved change description.=
=0D
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n94=0D
> =0D
> * How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D an=
d =E2=80=9CCc=E2=80=9D) accordingly?=0D
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.12-rc5#n145=0D
> =0D
> =0D
> Regards,=0D
> Markus=0D
=0D
Hi Markus,=0D
   Thanks for your help,I will modify the commit information and add Fixes.=
=0D
=0D
Thanks!=0D
Pei Xiao.=0D

