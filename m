Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A5C25416A
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgH0JDz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 05:03:55 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5862 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726266AbgH0JDy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 05:03:54 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R91vfa000570;
        Thu, 27 Aug 2020 11:03:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=lx+QYBokaHHL/CwY5ofgZfT1OTJOb3G3GrKi86P18Gg=;
 b=ubV2Bnqr1skfZO4yPCcWRoIojbuL/jlVBuomhD2W2lLk5pDPpQ0LlyLtoQMZN/lBReaw
 Rdeqq8taJzY6cskIYqssKEVzEVu1cOeqjfIcxstmWnGl66DPSYT2MEhtA9cfsqWWhibQ
 m+rTm+oymrqq5T4fPJYXK/Wa3aeMXg10sBL7XXnlIf/2T4mIgvkmK5P5RyQcLrVc1L7r
 8MfVkOQxb5vohvuLuLJHZIXpfsHOlI7yM5TifWHNP2IuR/snueCbXdBvdN4jVKlvVut8
 tjOpIMszwyr/130JT8H0geA0cNpMqfhZFfvNcAiVb/pRDCexoYl//s1BiTJKOgwxZnhY FQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 333b3hn6a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 11:03:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 827DE10002A;
        Thu, 27 Aug 2020 11:03:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6AF5B221159;
        Thu, 27 Aug 2020 11:03:25 +0200 (CEST)
Received: from [10.48.1.149] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Aug
 2020 11:03:24 +0200
Subject: Re: [PATCH v2] iio: stm32-dac: Replace indio_dev->mlock with own
 device lock
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <jic23@kernel.org>, <alexandre.torgue@st.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
References: <20200826063850.47625-1-alexandru.ardelean@analog.com>
 <20200826120042.200364-1-alexandru.ardelean@analog.com>
 <CA+U=DsrMDSTQKEc2_3+W8u4bLraAowVB3nB4huKY--v8gnds2Q@mail.gmail.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <c3a9411e-186d-a3ac-5ad0-bd70ad78f147@st.com>
Date:   Thu, 27 Aug 2020 11:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+U=DsrMDSTQKEc2_3+W8u4bLraAowVB3nB4huKY--v8gnds2Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_02:2020-08-27,2020-08-27 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/27/20 10:55 AM, Alexandru Ardelean wrote:
> On Wed, Aug 26, 2020 at 3:03 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
>> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>>
>> As part of the general cleanup of indio_dev->mlock, this change replaces
>> it with a local lock. The lock protects against potential races when
>> reading the CR reg and then updating, so that the state of pm_runtime
>> is consistent between the two operations.
>>
>> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>> ---
> Forgot the changelog here.
> Apologies.
> 
> Changelog v1 -> v2:
> * removed whitespace change for 'common' field
> * updated comment about the lock usage

Hi Alexandru,

Sorry if I missed it... is there an update on the comment :-) ?

Best Regards,
Fabrice
> 
>>  drivers/iio/dac/stm32-dac.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
>> index 092c796fa3d9..7a8aed476850 100644
>> --- a/drivers/iio/dac/stm32-dac.c
>> +++ b/drivers/iio/dac/stm32-dac.c
>> @@ -26,9 +26,11 @@
>>  /**
>>   * struct stm32_dac - private data of DAC driver
>>   * @common:            reference to DAC common data
>> + * @lock:              lock to protect the data buffer during regmap ops
>>   */
>>  struct stm32_dac {
>>         struct stm32_dac_common *common;
>> +       struct mutex            lock;
>>  };
