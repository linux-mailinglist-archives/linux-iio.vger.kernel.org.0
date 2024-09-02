Return-Path: <linux-iio+bounces-8954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E88967EEB
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 07:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1563281137
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 05:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C762914EC7D;
	Mon,  2 Sep 2024 05:49:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDB033F6;
	Mon,  2 Sep 2024 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256175; cv=none; b=LSk8qg/RksBA9KY+VFI9BxScDvyeu81YJKasR6WnrVi8pH0GAYob7MyM/Sp9Z2cr7673UEESdKbe44W4UTge1+NdD6kyk9YILqm10sGcpM038udLy4e98sRDRgiRii8Y1EnCTI1MXA54zVgb2TGfEx767IlhM5qgtIQhtOsTKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256175; c=relaxed/simple;
	bh=TceHUtx5GxjWUVhuqfqamkAFjBFTFKj3XO6mCtNgIV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ob8DjG8U+abbTtk24e/xwKyGFi4MorwvDv8KfEOdCB4MxOgcQouIRAgVfphbvj5NOhVb9PqPIvBJFZ+9lJNFnWnFE9SO0bYfrtOFUxXyPE9GbELGhWYLUwQd1L0XjSCVi2Fe1ZD3VGq53IKZ5E1WKCUEXrcAK2HO7guD35VIXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee266d551e1d21-05d28;
	Mon, 02 Sep 2024 13:49:21 +0800 (CST)
X-RM-TRANSID:2ee266d551e1d21-05d28
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766d551e0741-8a810;
	Mon, 02 Sep 2024 13:49:21 +0800 (CST)
X-RM-TRANSID:2ee766d551e0741-8a810
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangjiao <zhangjiao2@cmss.chinamobile.com>
Subject: Re: [PATCH] tools: iio: rm .*.cmd when make clean
Date: Mon,  2 Sep 2024 11:54:12 +0800
Message-Id: <20240902035412.4835-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240831115931.596e35fb@jic23-huawei>
References: <20240831115931.596e35fb@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhangjiao <zhangjiao2@cmss.chinamobile.com>

Hi

On Sat, 31 Aug 2024 11:59:31, Jonathan Cameron wrote:
>> On Thu, 29 Aug 2024 13:33:09 +0800
>> zhangjiao2 <zhangjiao2@cmss.chinamobile.com> wrote:
>> From: zhangjiao <zhangjiao2@cmss.chinamobile.com>
>> 
>> rm .*.cmd when make clean
> Where do those come from?
	Those come from tools/build/Build.include.
These .*.cmd files ware created when make.
So clean them when make clean.
>> Signed-off-by: zhangjiao <zhangjiao2@cmss.chinamobile.com>
>> ---
>>  tools/iio/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
>> index fa720f062229..3bcce0b7d10f 100644
>> --- a/tools/iio/Makefile
>> +++ b/tools/iio/Makefile
>> @@ -58,7 +58,7 @@ $(OUTPUT)iio_generic_buffer: $(IIO_GENERIC_BUFFER_IN)
>>  clean:
>>  	rm -f $(ALL_PROGRAMS)
>>  	rm -rf $(OUTPUT)include/linux/iio
>> -	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
>> +	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.cmd' -delete
>>  
>>  install: $(ALL_PROGRAMS)
>>  	install -d -m 755 $(DESTDIR)$(bindir);		\
-- 
Thanks

zhang jiao




