Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C219B96AD
	for <lists+linux-iio@lfdr.de>; Fri, 20 Sep 2019 19:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393047AbfITRki (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Sep 2019 13:40:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47824 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392294AbfITRki (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Sep 2019 13:40:38 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8KHeb7T042691;
        Fri, 20 Sep 2019 12:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569001237;
        bh=C98raCZo6yaGrTqJu6OdP7tFiXPZv5bL+4qtXQMIjaY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=XnCKY29lHQPI+hHUuvqcwv1KccP08O1zQgDD+oF0X7jZZ+ts6j/srCGdDqWPxAUVy
         e3B2NeoRFGW9shq0akYEDMNRMAVZnxNprhK3ihopwwA7SsDbNffTmntn4Su1eppf6k
         IfOeLrxf7CuFxk9vW0E9Ff1g1ufvKA3I/L8rP4ew=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8KHebp9106421;
        Fri, 20 Sep 2019 12:40:37 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 20
 Sep 2019 12:40:37 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 20 Sep 2019 12:40:33 -0500
Received: from jiji (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8KHebi9063913;
        Fri, 20 Sep 2019 12:40:37 -0500
Date:   Fri, 20 Sep 2019 12:40:37 -0500
From:   Andreas Dannenberg <dannenberg@ti.com>
To:     David Frey <dpfrey@gmail.com>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: light: opt3001: fix mutex unlock race
Message-ID: <20190920174037.6zfjcx36bejhoa5v@jiji>
References: <20190919225418.20512-1-dpfrey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190919225418.20512-1-dpfrey@gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

David,

On Thu, Sep 19, 2019 at 03:54:18PM -0700, David Frey wrote:
> When an end-of-conversion interrupt is received after performing a
> single-shot reading of the light sensor, the driver was waking up the
> result ready queue before checking opt->ok_to_ignore_lock to determine
> if it should unlock the mutex. The problem occurred in the case where
> the other thread woke up and changed the value of opt->ok_to_ignore_lock
> to false prior to the interrupt thread performing its read of the
> variable. In this case, the mutex would be unlocked twice.
> 
> Signed-off-by: David Frey <dpfrey@gmail.com>
> ---

Good find, thanks for the submission.

Reviewed-by: Andreas Dannenberg <dannenberg@ti.com>


--
Andreas Dannenberg
Texas Instruments Inc

>  drivers/iio/light/opt3001.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index e666879007d2..92004a2563ea 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -686,6 +686,7 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
>  	struct iio_dev *iio = _iio;
>  	struct opt3001 *opt = iio_priv(iio);
>  	int ret;
> +	bool wake_result_ready_queue = false;
>  
>  	if (!opt->ok_to_ignore_lock)
>  		mutex_lock(&opt->lock);
> @@ -720,13 +721,16 @@ static irqreturn_t opt3001_irq(int irq, void *_iio)
>  		}
>  		opt->result = ret;
>  		opt->result_ready = true;
> -		wake_up(&opt->result_ready_queue);
> +		wake_result_ready_queue = true;
>  	}
>  
>  out:
>  	if (!opt->ok_to_ignore_lock)
>  		mutex_unlock(&opt->lock);
>  
> +	if (wake_result_ready_queue)
> +		wake_up(&opt->result_ready_queue);
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.23.0
> 
