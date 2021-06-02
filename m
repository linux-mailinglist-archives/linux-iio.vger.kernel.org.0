Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587C2399259
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 20:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhFBST5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 14:19:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229467AbhFBST4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 14:19:56 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 152I5wq9019023;
        Wed, 2 Jun 2021 14:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : references :
 to : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=pCm3uA2/y6oX96XvFkOKCNeW27f/i5bBvmDC1IDRq2U=;
 b=SvpFpo+grrnIzJ4LDdc0cFJNKWjGIqzJIxIeCWLeMuQm4lSgaLAsZmS5ZSs2WP2MmoF7
 mEvRgJd92zSYk6g2a5UNN0khgVXmNyX82qPGMnTnNdKghNFTIvipjIjvZBj6ZXGEpyGM
 SC93DJID3GmaaQfw0tQJlIMP1d/tPVoHs8YEDUM71L5FJiGW4wo8L8Y2E9V/5gTLbAAg
 2ks6HlEPZfnjR7ERs2Ys7TE04uDI8WZJnoJ7VOqHZP0dX+RT5YyHs5efT/+f63oDOa2/
 jm+aO8cV1h1QGdyy22q/kX5sxr0WiSf0srVva299hXxZKAdsxLLo8GbOSlQc6EQd93z1 JQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 38xcdgn4bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 14:18:01 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 152ICh4N011442;
        Wed, 2 Jun 2021 18:18:01 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 38ud8aa0vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Jun 2021 18:18:01 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 152II0kJ29294936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Jun 2021 18:18:00 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FB3FAC05F;
        Wed,  2 Jun 2021 18:18:00 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A3D2AC059;
        Wed,  2 Jun 2021 18:17:59 +0000 (GMT)
Received: from [9.211.138.111] (unknown [9.211.138.111])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jun 2021 18:17:59 +0000 (GMT)
Subject: Fwd: Seeking your opinion on ways to report both Altitude and
 Pressure sensors for the DPS310 as well as Temperature from dbus-sensors.
References: <7a1dcde4-25df-ceee-a481-4a2f4afcf5bf@linux.vnet.ibm.com>
To:     linux@roeck-us.net, groeck@chromium.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Milton Miller II <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
From:   Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
X-Forwarded-Message-Id: <7a1dcde4-25df-ceee-a481-4a2f4afcf5bf@linux.vnet.ibm.com>
Message-ID: <f1add89a-853d-2ddd-b07e-6345eb54e72b@linux.vnet.ibm.com>
Date:   Wed, 2 Jun 2021 11:17:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <7a1dcde4-25df-ceee-a481-4a2f4afcf5bf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uPOeE9f28JI0_z03mNVGLpq27GDIzPuR
X-Proofpoint-GUID: uPOeE9f28JI0_z03mNVGLpq27GDIzPuR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_10:2021-06-02,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020111
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Forwarded to an expanded the To and Cc Lists.

On 6/2/2021 09:21, Ed Tanous wrote:
> On Wed, Jun 2, 2021 at 9:14 AM Bruce Mitchell
> <bruce.mitchell@linux.vnet.ibm.com> wrote:
>>
>> On 6/2/2021 09:03, Ed Tanous wrote:
>>> On Wed, Jun 2, 2021 at 8:58 AM Bruce Mitchell
>>> <bruce.mitchell@linux.vnet.ibm.com> wrote:
>>>>
>>>> On 6/2/2021 08:39, Ed Tanous wrote:
>>>>> On Tue, Jun 1, 2021 at 8:43 AM Bruce Mitchell
>>>>> <bruce.mitchell@linux.vnet.ibm.com> wrote:
>>>>>>
>>>>>> Hello Ed,
>>>>>>
>>>>>> It has been suggest I seeking your opinion on ways to report both
>>>>>> Altitude and Pressure sensors for the DPS310 as well as Temperature from
>>>>>> dbus-sensors before going to far down the road.  Thus that is what I am
>>>>>> attempting to do in the email, others on the mailing list input is
>>>>>> desirable as well.
>>>>>
>>>>> Thanks for discussing this before getting too far along.  I haven't
>>>>> worked on any systems with physical pressure sensors, but I'm excited
>>>>> to see new things get added.
>>>>>
>>>>>>
>>>>>> As I see it, Altitude and Pressure are different in that
>>>>>>         1) Altitude is computed base off of essentially a policy
>>>>>
>>>>> I have no idea what this means.....   In what way is altitude a
>>>>> "policy"?  Can you elaborate a little?
>>>>>
>>>>
>>>> I view a mechanism is something like update a FLASH part with
>>>> an image provided.
>>>>
>>>> I view a policy is what decides if the the update of the FLASH part
>>>> with the specific image is allowed.
>>>>
>>>> I the case if Pressure and Temperature I view them as mechanism,
>>>> merely a simple reading and possibly some well defined computations
>>>> that are universal.
>>>>
>>>> With Altitude computed from Pressure there are several ways to
>>>> compute the Altitude and they are not universal.  So I see it as
>>>> a policy of which Pressure to Altitude model is chosen and why.
>>>
>>> Sounds like I interpreted your intention correctly. (I think).
>>
>> I believe you did.
>>
>>>
>>>>
>>>>>>         2) Pressures is a read measurement which is a mechanism
>>>>>>         3) Temperature is a read measurement which is also a mechanism
>>>>>
>>>>> I'm really struggling with the above to understand what you're getting
>>>>> after, so if I go down the wrong path, please forgive me.
>>>>>
>>>>> I think what you're saying is that altitude is calculated based on
>>>>> pressure + some transfer function to determine an altitude?  And that
>>>>> transfer function might be fungible depending on the platform?
>>>>>
>>>>> If I got the above right (big if) I would probably expect a new
>>>>> pressure sensor type to be added that reports a pressure sensor, then
>>>>> we'd put the transform code in something that looks a lot like CFM
>>>>> sensor (which oddly enough has a hardcoded 0 for altitude in its
>>>>> algorithm for systems without pressure sensors).  Considering how
>>>>> related a pressure sensor is to altitude, I could see putting them in
>>>>> the same application if you wanted;  It might simplify the code some.
>>>>>
>>>>>
>>>>> I think overall a better picture of what you're wanting to accomplish
>>>>> would be a good place to start, then we can iterate from there on what
>>>>> pieces we need that are new.
>>>>
>>>> I have Temperature, Pressure, possibly Humidity sensors all which are
>>>> variables to different models to compute Altitude from.  I do not have a
>>>> true Altitude sensor.
>>>
>>> This sounds exactly like the CFM sensor, and Exit air temp sensor;
>>> Most systems don't have exit air temp sensors, but they have input
>>> power and individual fan speeds, which can be put into models to
>>> determine CFM and ultimately exit air temperature.  I would expect
>>> Altitude to do something very similar in code (although with a
>>> completely different algorithm).
>>>
>>
>> So the DPS310 has 2 sensors in it a Pressure and a Temperature sensor.
>> Do I create a Pressure reading and a Temperature reading for the DPS310
>> and then add Altitude to it as well?
>>
>> Or do I create 3 separate things,  one for each Pressure, Temperature,
>> and Altitude?
> 
> Assuming in this case "things" are intended to mean "entity manager
> exposes records" you would create one config record for the DPS310
> itself (which would in turn create 2 sensors).  This is one "record"
> because physically it's one part, and can't be separated, similar to a
> TMP421.  After that, I would create another config record for the
> "Here's the math to combine these into an altitude".  It might just be
> a type and a name, depending on how many inputs go into the transfer
> function to convert pressure+temperature into an altitude.
> 
> If the math to combine into an altitude isn't system specific, I could
> be convinced that the math should go into a single record within the
> DPS310 exposes and have that live in the daemon itself, but I don't
> have enough detail on how these are usually deployed to know that.
> 

I prefer the the 2 record solution, it keeps the DPS310 self-contained.
And keeps the Altitude self-contained, to the models can evolve and 
change; also if every a true altitude sensor were created it would help 
keep better abstraction from the DPS310.

>>
>> Also I believe I should be looking to the CFM sensor and Exit air
>> temperature sensor as reference examples.
>>
>>>>
>>>> I am being asked to provide Altitude.
>>>>
>>>> Personally I believe the desired feature is how much cooling a parcel of
>>>> air per unit of time.  Thus I would think air Temperature, Humidity, and
>>>> Density (probably compute-able from Pressure, but I have not checked on
>>>> the specifics) would be the important factors.
>>

Thank you Ed!
