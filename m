Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B063A18BECD
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 18:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgCSRyF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 13:54:05 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:9656 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgCSRyF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 13:54:05 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02JHm9SF030010;
        Thu, 19 Mar 2020 18:53:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=xhvicN/AH/49Tg2jHic/L9lkAzHjv3HYlGeap+CFKCw=;
 b=itPC5gsA4ELXAaE5a2xDmNDrb5QWsSt9ffWnFFkd989qno6/JM/OpyoT751KRmhW/tNQ
 71qYW6KimHr6RiyjbBsoHXLoJDqjWKcnirjzDlAMbVwek7QEQhR+Ik69n4vnor64SVHA
 4hCbsJHZMCrK5CPkIrUwH6pb9kkTCOuc5qvL4zMOLcXfH6lhm0OWuEP8vuyvHdiidnt5
 IJfMlkjybMUpN4QYPBsXJ6KsXlqPMPsN9yTboHVu94k1OUH6FGjAsoH+1B/HTR194Xzp
 nZgRYNOWW7u+QfXgNj0UJ9jkZT+EqGp6R266rND85YqQsEPi4/k1HkncEl4vdZmJAqgL 4w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu8etk926-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 18:53:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1CBB6100034;
        Thu, 19 Mar 2020 18:53:23 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0DC32BC7BA;
        Thu, 19 Mar 2020 18:53:22 +0100 (CET)
Received: from [10.211.9.6] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Mar
 2020 18:53:21 +0100
Subject: Re: [PATCH] dt-bindings: iio: dac: stm32-dac: convert bindings to
 json-schema
To:     Rob Herring <robh@kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1584543037-32095-1-git-send-email-fabrice.gasnier@st.com>
 <20200319171231.GA17071@bogus>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <3a1474bd-ae64-96f8-d094-545e0e2eff6c@st.com>
Date:   Thu, 19 Mar 2020 18:53:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200319171231.GA17071@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-19_06:2020-03-19,2020-03-19 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/19/20 6:12 PM, Rob Herring wrote:
> On Wed, 18 Mar 2020 15:50:37 +0100, Fabrice Gasnier wrote:
>> Convert the STM32 DAC binding to DT schema format using json-schema
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
>> ---
>>  .../devicetree/bindings/iio/dac/st,stm32-dac.txt   |  63 ------------
>>  .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  | 110 +++++++++++++++++++++
>>  2 files changed, 110 insertions(+), 63 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.txt
>>  create mode 100644 Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/iio/dac/st,stm32-dac.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/iio/dac/st,stm32-dac.yaml#
> 
> See https://patchwork.ozlabs.org/patch/1257568
> Please check and re-submit.

Hi Rob,

Just sent a V2.

I fear it's a copy/paste from another patch:
https://patchwork.ozlabs.org/patch/1223488/
dt-bindings: iio: adc: stm32-adc: convert bindings to json-schema

Should I send a fix for this one also ?

Please advise,
Fabrice
> 
