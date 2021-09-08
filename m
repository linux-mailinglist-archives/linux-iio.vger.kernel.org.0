Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2C24040E0
	for <lists+linux-iio@lfdr.de>; Thu,  9 Sep 2021 00:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239176AbhIHWLr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Sep 2021 18:11:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51024 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235838AbhIHWLq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Sep 2021 18:11:46 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188M4X3K144818;
        Wed, 8 Sep 2021 18:10:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject : cc
 : message-id : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=b9x3oRh8MZw+fajwDTUTnPibc6ayG4FOeIE6rifl6eg=;
 b=Tp8Cb4ZDQA3JKTBVyxcbT4b/OJC443C8POd2PQrcj16k4UlRTl/DZzaffbQGJqg9N1Vf
 iedXYzRr/759VxaO1nXrhpSDI8RBwIb8heVTgrhqUZG5YV4YhUEzPfLh0B8Vgs53FGA6
 RbiUlFrq6p7cqrIiJwOG36ptAg2U9gnO/Kv3kJgXfMyogpgHpC+ZJ8490KC1e3FQkLy5
 +6fqvV/wgxxGAGRqxIzvmqDdB3R8zV/S77gRWR4OmlW3wXJZB00lzeufQIf47sNrsFFV
 zpC+BnZGyKken93R71UW79KgS44CsaYPGFQl62t7gVGxOflyF2pb83ZQhS57ysIsD8zM PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axuwjrge5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 18:10:32 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 188M69qL004771;
        Wed, 8 Sep 2021 18:10:32 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axuwjrgdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 18:10:32 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188M7PXD012160;
        Wed, 8 Sep 2021 22:10:31 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03wdc.us.ibm.com with ESMTP id 3axcnpp8g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 22:10:31 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188MAUmk10748516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 22:10:30 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AA36AE075;
        Wed,  8 Sep 2021 22:10:30 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20F94AE06D;
        Wed,  8 Sep 2021 22:10:30 +0000 (GMT)
Received: from [9.163.8.88] (unknown [9.163.8.88])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 22:10:29 +0000 (GMT)
To:     linux-iio@vger.kernel.org
From:   Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Subject: Looking for clarification on sysfs IIO devices, do _raw devices
 require both _offset and _scale?
Cc:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Ed Tanous <ed@tanous.net>, Ed Tanous <edtanous@google.com>
Message-ID: <cc74f30f-9ab8-45ce-1f44-8e55c3f9c5ce@linux.vnet.ibm.com>
Date:   Wed, 8 Sep 2021 15:10:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vZVx-s3ktMXmxkZ-ANW_G8woawIqPiAD
X-Proofpoint-ORIG-GUID: D_yOftcodq6APUje3OThdH2xvvos9gAf
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_09:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080137
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In reference to:
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio

I have Temperature, Pressure, and Humidity IIO sensors.
IIO _raw devices look like this on sysfs:
   this happens to be a SI7020 type device with 2 sensors
     /sys/bus/iio/devices/iio:device0/in_humidityrelative_offset
     /sys/bus/iio/devices/iio:device0/in_humidityrelative_raw
     /sys/bus/iio/devices/iio:device0/in_humidityrelative_scale
     /sys/bus/iio/devices/iio:device0/in_temp_offset
     /sys/bus/iio/devices/iio:device0/in_temp_raw
     /sys/bus/iio/devices/iio:device0/in_temp_scale

Other IIO _input devices look like this on sysfs:
   this happens to be a DPS310 device with 2 sensors
      /sys/bus/iio/devices/iio:device1/in_temp_input
      /sys/bus/iio/devices/iio:device1/in_pressure_input

As I read it if the IIO device was an _input type on sysfs,
just read it (and possibly scale it for units).

But if the IIO device was a _raw type on sysfs my understanding
is that it must be accompanied by a _offset and a _scale for
at least temperature, pressure, humidity, voltage, and current
sensors.
Is that correct?

Further for any IIO device that is a _raw type on sysfs is it
required to be accompanied by a _offset and a _scale as well?


Thank you!

-- 
Bruce
