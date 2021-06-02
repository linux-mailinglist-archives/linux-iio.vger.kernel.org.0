Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2524D399249
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 20:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhFBSQJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 14:16:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229489AbhFBSQI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 14:16:08 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152I5Lsf044105;
        Wed, 2 Jun 2021 14:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : references :
 from : cc : to : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=efXASxl18sqm2/zKZy/xp831Mgm0BSyhusUav6KAX4w=;
 b=pGmBHiumltIKK8/ij4+/Max8Sv2Ng/UV0VzcUuCYVLPj5fUGOAVuvIhvpAzQUZ6nuynJ
 wz7b5VZSDDsNWcJkHWNjOeCsf+joIW/b2gHDr86vqZNKADoGYEkGtMjEOQIPtzUvFl1u
 VP+VVJHcHVZyWtdrPAqa/1aDWg0GWzOZ5W1JIn7MoobNJ1XwBF05M9xY4uxOmtMUpdUi
 HtG6MdZMPVKD7AV/3hf9hZJS32k4/fn8CqhjH7ZysszguH/NbhPuwrAgyp/xMejkwLxA
 A4PP0IEIlcodPOAVTCERKiHPSpwRZxF7ccbcB3viS4QXd+9JqArl3zH1oXY7E7rqh3K6 +A== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38xap9guk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 14:14:13 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152ICR1w023260;
        Wed, 2 Jun 2021 18:14:12 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 38ud899m4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 18:14:12 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152IECMt34144694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 18:14:12 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33DD3AC05E;
        Wed,  2 Jun 2021 18:14:12 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7397CAC05B;
        Wed,  2 Jun 2021 18:14:11 +0000 (GMT)
Received: from [9.211.138.111] (unknown [9.211.138.111])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jun 2021 18:14:11 +0000 (GMT)
Subject: Regarding Pressure sensors for atmospheric, station, and barometric
 pressures.
References: <9681d2a6-c820-c5a0-2cc1-e0b7fc808dae@linux.vnet.ibm.com>
From:   Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Cc:     linux-iio@vger.kernel.org, Milton Miller II <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
To:     linux@roeck-us.net, groeck@chromium.org,
        linux-hwmon@vger.kernel.org
X-Forwarded-Message-Id: <9681d2a6-c820-c5a0-2cc1-e0b7fc808dae@linux.vnet.ibm.com>
Message-ID: <ca1268bd-8134-352f-bfc1-665abfa7f42c@linux.vnet.ibm.com>
Date:   Wed, 2 Jun 2021 11:14:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <9681d2a6-c820-c5a0-2cc1-e0b7fc808dae@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _HGUQbVdeAhIM-YtMgweh0mTGLe9WJrH
X-Proofpoint-ORIG-GUID: _HGUQbVdeAhIM-YtMgweh0mTGLe9WJrH
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_10:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020115
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Guenter,

I've been asked to expand the To list to include you and hwmon.

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
