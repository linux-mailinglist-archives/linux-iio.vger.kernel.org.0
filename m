Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 446D719316D
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 20:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCYTtH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 15:49:07 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42437 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgCYTtH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 15:49:07 -0400
Received: by mail-lj1-f196.google.com with SMTP id q19so3848125ljp.9
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2020 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=nTTr2eT8beyiIymOMo76DAaIB8vzHPaPB42j8ZMAkVk=;
        b=fkGvrmA/AdOv8Peswja3c+r+b+rsNFArIL6xQEJNT9T67qsYNbRfZQ5GS6Roxd9R7x
         xei/DKw5xsiuAE+BARbS4f/zVikuVXVmqTH/ilozzxx5iGCCxLUMeWxqac+4mu5J8ihi
         Qp+DUrRi0jnu7O/u9NAvnkJE665JhKl1qn0sa3LbkZMHKnZPnGXiAd0231SLXfzYEwwA
         39OwbzVHr9T17w/X18Flg3+lOdfbFWVn7YifCBfAdP75ta9L6/njMQ/6E4xNM9AXZG+A
         bhVkKFQSBhMK2dNfBJMbjjVTiLsekI3Jc6I+Ds0sXU7GR4nCU+Ewuzxqs4z4CUN/sESr
         GbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTTr2eT8beyiIymOMo76DAaIB8vzHPaPB42j8ZMAkVk=;
        b=mrG5VYsYt7WZsHD2r3AcEopXGAFVASV59RgtyzZY4kRrQUH15CCxpyL+UM+FANInvY
         AqZpla5hZHCHMF2UnqpCXfpL3eD011Tgp6QzNF78Jws1SEe4mv2vAGCRGLm44W/mniNT
         Jjukd1QP058hfRS2YVxB5Tz57zyJ3Fgiks5u5PlCffpQIRrUuh6UHeOyOGSEoFZKvN+c
         I89PWxV7kiLYNP4wZaegRdWbPAzEWECkj21ZCTEStU5tmXo7jnkAxGl391pd2PCdOBe8
         BBAgnbIzwwQ2lG6v5TkJoR+gZY4fwEHPcoGTQURLQcIH1gh6RGr3lnGXrMvt4UQNFJbs
         1FYg==
X-Gm-Message-State: ANhLgQ3XJ1GrREShdNw+DElIGmkqLIPOo6fXebwMN8fRisb8L6F8cPIK
        rTF9nBg7szBiuGpm89QgBkZq9lRbERA=
X-Google-Smtp-Source: APiQypJ7QOyaxrR2VI6AyUeN50AK+qEtL247sdcWDvxlgw8er/PhwFhGpdNB07BhJ8VwhZcajVIwig==
X-Received: by 2002:a2e:9797:: with SMTP id y23mr2924652lji.183.1585165745101;
        Wed, 25 Mar 2020 12:49:05 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id k14sm12652639lfg.96.2020.03.25.12.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2020 12:49:04 -0700 (PDT)
Subject: Re: [PATCH v2 12/13] iio: imu: inv_mpu6050: use runtime pm with
 autosuspend
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200219143958.3548-1-jmaneyrol@invensense.com>
 <20200219143958.3548-13-jmaneyrol@invensense.com>
 <e7c7dc02-bf91-9300-19c5-ce8fe16f549f@gmail.com>
 <MN2PR12MB44226E64423AA0338D061636C4CE0@MN2PR12MB4422.namprd12.prod.outlook.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <78fd9ec4-1171-b27a-9e17-d7ee6793c944@gmail.com>
Date:   Wed, 25 Mar 2020 22:49:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB44226E64423AA0338D061636C4CE0@MN2PR12MB4422.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

25.03.2020 22:21, Jean-Baptiste Maneyrol пишет:
> Hello Dmitry,
> 
> that's right, thanks for finding it.
> 
> Hopefully this will not prevent system suspend since we are not checking on the return value.

Probably should be okay.

> System suspend/resume callbacks need to be reworked to work correctly with pm_runtime.
> I will send a fix patch when it is ready.

Thank you very much.
