Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A3398FED
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 18:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhFBQ37 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 12:29:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53060 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229541AbhFBQ37 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 12:29:59 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152G3sNl053400
        for <linux-iio@vger.kernel.org>; Wed, 2 Jun 2021 12:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=wVH5Kwcc5CbnyzSPEbE95XbZ6OwtCrEisa7esP3agis=;
 b=EyEnRCLhSMZ0f7CTgA+M2eAv93tcPi46ZYLr1KS1ghcscu+2t9PyjBWQpCKBB3IU12pa
 1ZPJ9zWj4xYo4KxC7ipNeZfl1H1dycRp4gb+0kE4WMgCezeLsL6/lklyLnGksslIbSiz
 Q8MGApGgr+TKPKzd0f1iXYdEnd7SndT0CefKvk7vgraqR1kha+NHWrmxeXj0Iro5NrDX
 RZujDfQeOoH28Cm/k4ihFOt1BidyWZRCGkTN01Dv8j+EKjjeEDqwnC8QMido8pN4Nf8v
 cT7VLek8d/5WqLpNA/t+hWsTqtzF+iGG831SThg+tZryA6Kn3XeMNku7NMIgwVKK7GsL 5Q== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xd378v6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 12:28:16 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152GDa3I007421
        for <linux-iio@vger.kernel.org>; Wed, 2 Jun 2021 16:28:15 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 38ud898yge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 16:28:15 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152GSEQA36176128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Wed, 2 Jun 2021 16:28:14 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89D3EAC059
        for <linux-iio@vger.kernel.org>; Wed,  2 Jun 2021 16:28:14 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C696AC05B
        for <linux-iio@vger.kernel.org>; Wed,  2 Jun 2021 16:28:14 +0000 (GMT)
Received: from [9.211.138.111] (unknown [9.211.138.111])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP
        for <linux-iio@vger.kernel.org>; Wed,  2 Jun 2021 16:28:14 +0000 (GMT)
To:     linux-iio@vger.kernel.org
From:   Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Subject: Regarding Pressure sensors for atmospheric, station, and barometric
 pressures.
Message-ID: <9681d2a6-c820-c5a0-2cc1-e0b7fc808dae@linux.vnet.ibm.com>
Date:   Wed, 2 Jun 2021 09:28:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hnvkpYLsydLARJhgPZBwNI3xVmKAP4Aj
X-Proofpoint-GUID: hnvkpYLsydLARJhgPZBwNI3xVmKAP4Aj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_08:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020101
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello linux-iio@vger.kernel.org,

In reference to:
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio

There is this section:

What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_raw
What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_raw
KernelVersion:	3.8
Contact:	linux-iio@vger.kernel.org
Description:
		Raw pressure measurement from channel Y. Units after
		application of scale and offset are kilopascal.

What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_input
What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_input
KernelVersion:	3.8
Contact:	linux-iio@vger.kernel.org
Description:
		Scaled pressure measurement from channel Y, in kilopascal.

What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
KernelVersion:	3.14
Contact:	linux-iio@vger.kernel.org
Description:
		Raw humidity measurement of air. Units after application of
		scale and offset are milli percent.

What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelative_input
KernelVersion:	3.14
Contact:	linux-iio@vger.kernel.org
Description:
		Scaled humidity measurement in milli percent.

Nowhere do I find the unit kilopascal used in atmospheric pressure.
To stick with International System of Units and its Prefixes
https://en.wikipedia.org/wiki/International_System_of_Units#Prefixes

The standard unit for used in atmospheric pressure measurements or 
readings is the hectopascal (hPa), in meteorology, for atmospheric 
pressure, the modern equivalent of the traditional millibar.

What would it take to make this change to the standard for
https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio ?

Thank you.

-- 
Bruce Mitchell
