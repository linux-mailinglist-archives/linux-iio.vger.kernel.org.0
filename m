Return-Path: <linux-iio+bounces-25276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08636BF02AA
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 11:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03975402DF3
	for <lists+linux-iio@lfdr.de>; Mon, 20 Oct 2025 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652AD2F260E;
	Mon, 20 Oct 2025 09:27:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2892C2F546D;
	Mon, 20 Oct 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952432; cv=none; b=ooT1wq2bgy03mHkN1slHG+1q8l1NcXmUVRXzaHFpSo+Wq99iS8fLtfDyiiHrIPLaYEU7NgFTuXd53Sz6qmvzwqehoYnrX/G5esAaGlZR8Wvs/WHQPNZVl6Bnt8SGMu7KBkZx8UvPcRvyeY9DtfD0qm9bF6ZEkbCaeZ+gQ0OYMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952432; c=relaxed/simple;
	bh=Z2gYF3gOzeqX6mk5y5jFtzBdK9lK9jcleEkXns3wUYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbT3cJy9JU/XYlN2UZT1vQGdZ877CARtms+mdtL3AHptIsBPJX1K6it4fW6RdQYi5c7SxPEkCh4pHaXS91Uc42BwjmggY9hrDuqarPzfVK3UgfF555+lKV9nlSIH2y9/BvSDbUl8L5bHjo0aIc0NDCC0O/Up2ZnR1piL4KgGxNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ed7ae332ad9611f0a38c85956e01ac42-20251020
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:dce9fd46-61cb-4524-b7d4-39d2bb690b89,IP:0,UR
	L:0,TC:0,Content:0,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:d9832ce7111d0b5b2c3f35b3ae267732,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|102|850,TC:nil,Content:0|50,EDM
	:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ed7ae332ad9611f0a38c85956e01ac42-20251020
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1051764157; Mon, 20 Oct 2025 17:26:58 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: eugen.hristev@linaro.org
Cc: alexandre.belloni@bootlin.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nicolas.ferre@microchip.com,
	xiaopei01@kylinos.cn
Subject: [PATCH] iio: adc: ti_am335x_adc: Limit step_avg to valid range for gcc complains
Date: Mon, 20 Oct 2025 17:26:55 +0800
Message-Id: <1208d71f952e3bb85076d229e5fc1b21e2735567.1760166576.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e9d6831a-d0ef-440c-b235-fec18048deed@linaro.org>
References: <e9d6831a-d0ef-440c-b235-fec18048deed@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 11/28/24 08:45, Pei Xiao wrote:
>> at91_adc_interrupt can call at91_adc_touch_data_handler function
>> to start the work by schedule_work(&st->touch_st.workq).
>> 
>> If we remove the module which will call at91_adc_remove to
>> make cleanup, it will free indio_dev through iio_device_unregister
>> while the work mentioned above will be used. The sequence of operations
>> that may lead to a UAF bug is as follows:
>> 
>> CPU0                                      CPU1
> 
>                                      | at91_adc_workq_handler
>> at91_adc_remove                      |
>> iio_device_unregister(indio_dev)     |
>> device_release                       |
>> //free indio_dev                     |
>                                      | iio_push_to_buffers(indio_dev)
>                                      | //use indio_dev
> 
> Fix it by ensuring that the work is canceled before proceeding with
> the cleanup in at91_adc_remove.
>> 
>> Fixes: 27e177190891 ("iio:adc:at91_adc8xx: introduce new atmel adc driver")

>I believe that the commit that introduced the workqueue is different
>than the one you tagged here.

>With that changed,

>Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

I am so sorry I have been ignoring this reply for almost a year..

>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> ---
>>  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
>> index 8e5aaf15a921..4ba52b500054 100644
>> --- a/drivers/iio/adc/at91-sama5d2_adc.c
>> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
>> @@ -2491,6 +2491,7 @@ static void at91_adc_remove(struct platform_device *pdev)
>>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>  	struct at91_adc_state *st = iio_priv(indio_dev);
>>  
>> +	cancel_work_sync(&st->touch_st.workq);
>>  	iio_device_unregister(indio_dev);
>>  
>>  	at91_adc_dma_disable(st);

