Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C98B2918EE
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 20:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgJRSy2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Oct 2020 14:54:28 -0400
Received: from mleia.com ([178.79.152.223]:50262 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbgJRSy1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Oct 2020 14:54:27 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2020 14:54:27 EDT
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 04EF1411E0F;
        Sun, 18 Oct 2020 18:44:36 +0000 (UTC)
Received: from [192.168.43.55] (83-245-236-133-nat-p.elisa-mobile.fi [83.245.236.133])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.mleia.com (Postfix) with ESMTPSA id 61A92411E0D;
        Sun, 18 Oct 2020 18:44:34 +0000 (UTC)
Subject: Re: [PATCH 22/29] dt-bindings:iio:dac:nxp,lpc1850-dac yaml
 conversion.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Joachim Eastwood <manabian@gmail.com>
References: <20201011170749.243680-1-jic23@kernel.org>
 <20201011170749.243680-23-jic23@kernel.org>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <fba099e8-869d-71c9-886f-1b565c855115@mleia.com>
Date:   Sun, 18 Oct 2020 21:44:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201011170749.243680-23-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20201018_184436_040563_459E3C54 
X-CRM114-Status: UNSURE (   9.19  )
X-CRM114-Notice: Please train this message. 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On 10/11/20 8:07 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Very similar binding to that for the ADC on the same device.
> Conversion from txt to yaml format.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> ---
>   .../bindings/iio/dac/lpc1850-dac.txt          | 19 ------
>   .../bindings/iio/dac/nxp,lpc1850-dac.yaml     | 58 +++++++++++++++++++
>   2 files changed, 58 insertions(+), 19 deletions(-)
> 

the conversion looks totally correct, thank you.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
