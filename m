Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2D15537
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2019 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfEFVEI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 May 2019 17:04:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57620 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbfEFVEI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 May 2019 17:04:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46L2rBE066582
        for <linux-iio@vger.kernel.org>; Mon, 6 May 2019 17:04:07 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2satf5mmvk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Mon, 06 May 2019 17:04:06 -0400
Received: from localhost
        by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-iio@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 6 May 2019 22:04:05 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 22:04:01 +0100
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46L41cZ55902416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 21:04:01 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E67C96A04F;
        Mon,  6 May 2019 21:04:00 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED8976A04D;
        Mon,  6 May 2019 21:03:59 +0000 (GMT)
Received: from [9.85.231.108] (unknown [9.85.231.108])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  6 May 2019 21:03:59 +0000 (GMT)
Subject: Re: [PATCH] iio: dps310: Add pressure sensing capability
To:     Jonathan Cameron <jic23@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
References: <1556721787-28500-1-git-send-email-eajames@linux.ibm.com>
 <CACPK8Xc2uwPwouto4Xg8fA0OAMJ3eP6kYjKcp9Bf4R90t1NdBg@mail.gmail.com>
 <20190505130951.08be3104@archlinux>
From:   Eddie James <eajames@linux.ibm.com>
Date:   Mon, 6 May 2019 16:03:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190505130951.08be3104@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19050621-8235-0000-0000-00000E9033D4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011062; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199565; UDB=6.00629334; IPR=6.00980441;
 MB=3.00026761; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-06 21:04:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050621-8236-0000-0000-00004573788C
Message-Id: <5225a66b-cda3-7cf3-358c-0703fef86f01@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060166
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 5/5/19 7:09 AM, Jonathan Cameron wrote:
> On Fri, 3 May 2019 02:34:30 +0000
> Joel Stanley <joel@jms.id.au> wrote:
>
>> Hi Eddie,
>>
>> On Wed, 1 May 2019 at 14:43, Eddie James <eajames@linux.ibm.com> wrote:
>>> The DPS310 supports measurement of pressure, so support that in the
>>> driver. Use background measurement like the temperature sensing and
>>> default to lowest precision and lowest measurement rate.
>> Upstream didn't accept my patch as they wanted it to support pressure
>> in addition to temperature first. I didn't ever get around to doing
>> that.
>>
>> I suggest you send my original patch and device tree binding along
>> with this one as a series.


The dps310 is already in the upstream witherspoon dts somehow :)


>>
>> Cheers,
>>
>> Joel
> Exactly as Joel says. Note there were some other minor bits and pieces
> in the last review I can find of Joel's driver that will also need
> tidying up..
>
> Great to see this driver making progress.


Thanks Joel and Jonathan, my mistake as I didn't base the patch on 
linux-next. I have submitted the series with a few cleanup changes for 
Joel's patch.


Thanks!

Eddie

>
> Thanks,
>
> Jonathan
>

