Return-Path: <linux-iio+bounces-25547-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB0BC1296D
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 02:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 012C14FC70B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Oct 2025 01:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C2F257841;
	Tue, 28 Oct 2025 01:51:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8964816F288;
	Tue, 28 Oct 2025 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616295; cv=none; b=l7SpeG5g816wrBE4yCi+aFvlN/dChDfq7bJd+OX1SP7j6mm3w7DPIz6SsndzTmjlFJZ/AxLQyzHn3rkkzt4YvKHPZx3bs5dGxNtBZQOX6L9Kqi8hsGyxxB+BsARpYTOUFZpS8bqbjmZPQ66cxqvwG5m9ezKbq+RbPe7Yn9caBiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616295; c=relaxed/simple;
	bh=fz4zgvfX8X+qirqfDKVSY1/HPFrH0WizlqSF0w34Si8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kk88La+gd/mvEgPb90gclhbaR4AWLPFWZsiB2SUyB2x/4lX+M6adJzgPTLg/VbkgjmMU1Qs80JZ+VsFLwH3mC5FGEu3JokEKJdTv6pFJ7KRLxm26lNmcs/AtycYeOPrYBaxe5c/bZgtjYk6FMQav3ZSGihRijfH0lAuhGfw6JwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 971a9f5eb3a011f0a38c85956e01ac42-20251028
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5d91b49d-5a66-40cf-9c7b-28aa208aa133,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:3839235e197e2efe96210ae0c772be0a,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850,TC:nil,Content:-
	10|-8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 971a9f5eb3a011f0a38c85956e01ac42-20251028
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 135765811; Tue, 28 Oct 2025 09:51:15 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: jic23@kernel.org
Cc: alexandre.belloni@bootlin.com,
	eugen.hristev@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: at91-sama5d2_adc: Fix potential use-after-free in sama5d2_adc driver
Date: Tue, 28 Oct 2025 09:51:13 +0800
Message-Id: <20251028015113.34609-1-xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251027134908.36d63b9f@jic23-huawei>
References: <20251027134908.36d63b9f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On Mon, 20 Oct 2025 15:49:25 +0800
> Pei Xiao <xiaopei01@kylinos.cn> wrote:
>
> > at91_adc_interrupt can call at91_adc_touch_data_handler function
> > to start the work by schedule_work(&st->touch_st.workq).
> > 
> > If we remove the module which will call at91_adc_remove to
> > make cleanup, it will free indio_dev through iio_device_unregister
> > while the work mentioned above will be used. The sequence of operations
> > that may lead to a UAF bug is as follows:
> > 
> > CPU0                                      CPU1
> > 
> >                                      | at91_adc_workq_handler
> > at91_adc_remove                      |
> > iio_device_unregister(indio_dev)     |
> > //free indio_dev                     |
> >                                      | iio_push_to_buffers(indio_dev)
> >                                      | //use indio_dev
>
> Hi,
>
> I'm not completely following your description here.
> The free doesn't happen in iio_device_unregister() but quite a bit later.
> So either the problem you are seeing is actually devm_ tear down that
> will do the free, or it's a more specific action in iio_device_unregister()
> though I'm not sure what it might be. Possibly a specific buffer mask
> getting torn down?  I haven't analysed it closely enough to figure out if
> there is a race there but it's the only thing I can immediately spot that
> would even be of interest to a work item in a driver via some core interfaces.
>
> Other than working out exact cause for anyone looking at this later, I'm
> also not sure you don't leave a potential race where a fresh request comes in
> between that cancel_work_sync() and the iio_device_unregister() call as it
> is only when iio_device_unregister() is complete that all interfaces are torn
> down that could start a fresh capture.
>
> So were the cancel_work_sync() one line later I would have been happy but
> from your description I'm not sure that fixes the bug you are seeing!
>
> Jonathan

Hi,

  Thank you for your reply email. 

  I haven't tested this bug, but I noticed this potential issue while

reading the code. So, can I send the v3 patch and move the 

cancel_work_sync to the next line of code?

Thanks!

Pei.
>
>
>
> > 
> > Fix it by ensuring that the work is canceled before proceeding with
> > the cleanup in at91_adc_remove.
> > 
> > Fixes: 3ec2774f1cc ("iio: adc: at91-sama5d2_adc: add support for position and pressure channels")
> > Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> > ---
> >  drivers/iio/adc/at91-sama5d2_adc.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> > index b4c36e6a7490..1cd6ce61cf17 100644
> > --- a/drivers/iio/adc/at91-sama5d2_adc.c
> > +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> > @@ -2480,6 +2480,7 @@ static void at91_adc_remove(struct platform_device *pdev)
> >  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >  	struct at91_adc_state *st = iio_priv(indio_dev);
> >  
> > +	cancel_work_sync(&st->touch_st.workq);
> >  	iio_device_unregister(indio_dev);
> >  
> >  	at91_adc_dma_disable(st);
>



