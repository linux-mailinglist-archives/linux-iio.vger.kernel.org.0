Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986EF3992DA
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 20:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhFBSwz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 14:52:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16916 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhFBSwz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 14:52:55 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152IWhEq029765;
        Wed, 2 Jun 2021 14:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aN4TsVtV/nxjKMcDwrd8pmxLdOG4qt7R1DnbN4mnzh4=;
 b=bNrqo7vNusslJQsy6kkn3tDXIrUC7q4efBEmwykkPShaHwlr+ZLQXV7l44gkIkEX2dFF
 TRyFliGMVdYlRKVA5+KcauT0Cg0eU1TsW2j6cpJo/syX8iFVmTu/hD5vt3X4YsDYnaJb
 EyStjdOOH6UYFkpCUkRRQNtY5unuFDn0SvotRogBMyb2jciCGD7RAk/UaTJoHDaZ7aRR
 6GwUa+01hCb7rttlwrNHLXmuHkD2zlTBifQIz95kcA8hb1Yaf6K9iZ3K0nUtIVf/Ls4e
 3TyuiVmBhbfHwkClB0Wj1QD+A+lLWRW3kMDmMeCFDWXflzRVf23W7uePHStprGo6x6qa CQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xewas6vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 14:50:59 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 152IXSOP032104;
        Wed, 2 Jun 2021 14:50:59 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xewas6vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 14:50:59 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152IlHQU011733;
        Wed, 2 Jun 2021 18:50:58 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 38ud89t7ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 18:50:58 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152Iov6g18088264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 18:50:57 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EF84AC09B;
        Wed,  2 Jun 2021 18:50:42 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6341AC064;
        Wed,  2 Jun 2021 18:50:41 +0000 (GMT)
Received: from [9.211.138.111] (unknown [9.211.138.111])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jun 2021 18:50:41 +0000 (GMT)
Subject: Re: Regarding Pressure sensors for atmospheric, station, and
 barometric pressures.
To:     Guenter Roeck <groeck@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Guenter Roeck <groeck@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        Milton Miller II <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
References: <9681d2a6-c820-c5a0-2cc1-e0b7fc808dae@linux.vnet.ibm.com>
 <ca1268bd-8134-352f-bfc1-665abfa7f42c@linux.vnet.ibm.com>
 <CABXOdTegoRVC_3Ks8sTnbhZaGmGXLu_w47Dx5BydLLkGX8Au3A@mail.gmail.com>
From:   Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Message-ID: <698068d1-a2b2-d8e1-5d8a-9d5ba251b8ff@linux.vnet.ibm.com>
Date:   Wed, 2 Jun 2021 11:50:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <CABXOdTegoRVC_3Ks8sTnbhZaGmGXLu_w47Dx5BydLLkGX8Au3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bBPhvg8ag-5Ga3s-Kk6ZmUlo7Yy6AM2z
X-Proofpoint-ORIG-GUID: praqjvYFTATicJBq1ON0iMoMWMOSXJKF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_10:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020118
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/2/2021 11:41, Guenter Roeck wrote:
> Hi Bruce,
> 
> On Wed, Jun 2, 2021 at 11:14 AM Bruce Mitchell
> <bruce.mitchell@linux.vnet.ibm.com> wrote:
>>
>> Hello Guenter,
>>
>> I've been asked to expand the To list to include you and hwmon.
>>
>> In reference to:
>> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio
>>
>> There is this section:
>>
>> What:           /sys/bus/iio/devices/iio:deviceX/in_pressureY_raw
>> What:           /sys/bus/iio/devices/iio:deviceX/in_pressure_raw
>> KernelVersion:  3.8
>> Contact:        linux-iio@vger.kernel.org
>> Description:
>>                  Raw pressure measurement from channel Y. Units after
>>                  application of scale and offset are kilopascal.
>>
>> What:           /sys/bus/iio/devices/iio:deviceX/in_pressureY_input
>> What:           /sys/bus/iio/devices/iio:deviceX/in_pressure_input
>> KernelVersion:  3.8
>> Contact:        linux-iio@vger.kernel.org
>> Description:
>>                  Scaled pressure measurement from channel Y, in kilopascal.
>>
>> What:           /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
>> KernelVersion:  3.14
>> Contact:        linux-iio@vger.kernel.org
>> Description:
>>                  Raw humidity measurement of air. Units after application of
>>                  scale and offset are milli percent.
>>
>> What:           /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_input
>> KernelVersion:  3.14
>> Contact:        linux-iio@vger.kernel.org
>> Description:
>>                  Scaled humidity measurement in milli percent.
>>
>> Nowhere do I find the unit kilopascal used in atmospheric pressure.
>> To stick with International System of Units and its Prefixes
>> https://en.wikipedia.org/wiki/International_System_of_Units#Prefixes
>>
>> The standard unit for used in atmospheric pressure measurements or
>> readings is the hectopascal (hPa), in meteorology, for atmospheric
>> pressure, the modern equivalent of the traditional millibar.
>>
>> What would it take to make this change to the standard for
>> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio ?
>>
> 
> The short answer is "you don't". The ABI states that pressure is reported in
> kilopascal, not in hectopascal. We can't change the ABI because existing
> user space code depends on it. Changing it would be equivalent to changing
> the ABI for, say, temperature from degrees C to degrees F, or Kelvin.
> 
> Quite frankly I don't see your problem. 1 kilopascal = 10 hectopascal. Take
> the reported number and multiply by 10. What am I missing ?
> 
> Obviously I _am_ missing the entire discussion so far, so my response may
> be  completely off track. If so, my apologies for the noise.
> 
> Thanks,
> Guenter
> 

Thank you Guenter, I don't have a problem scaling, as you suggest.
But if I don't ask I know I have a guaranteed NO.  I feel it is better 
to ask now and know the answer and deal with it appropriately.

-- 
Bruce

