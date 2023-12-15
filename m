Return-Path: <linux-iio+bounces-935-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D611814519
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 11:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030D828415D
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9305618C1A;
	Fri, 15 Dec 2023 10:04:23 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AE5182CC;
	Fri, 15 Dec 2023 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rE53I-0005EG-VC; Fri, 15 Dec 2023 11:04:17 +0100
Message-ID: <d3d6fe7a-d6e1-4ea6-a8f6-2430731691b2@leemhuis.info>
Date: Fri, 15 Dec 2023 11:04:19 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] Support light color temperature and chromaticity
Content-Language: en-US, de-DE
To: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas@t-8ch.de>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, jikos@kernel.org,
 benjamin.tissoires@redhat.com, lars@metafoo.de,
 srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, regressions@lists.linux.dev
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
 <4441bd6b-01cd-4f26-bf85-bde2e1bf404e@t-8ch.de>
 <20231210110735.52f8dc53@jic23-huawei>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20231210110735.52f8dc53@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1702634661;71de4177;
X-HE-SMSGID: 1rE53I-0005EG-VC

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Thomas, Jonathan, was any progress made to resolve below regression?

Side note: vormally I would not prod you at this time of the cycle, but
with the festive season coming up I thought it would be wise to ask a
bit earlier for a status update.

Ciao, Thorsten

On 10.12.23 12:07, Jonathan Cameron wrote:
> On Thu, 7 Dec 2023 00:39:28 +0100
> Thomas Weißschuh <thomas@t-8ch.de> wrote:
>> On 2023-09-19 13:40:45+0530, Basavaraj Natikar wrote:
>>> This series adds support for light color temperature and chromaticity.
>[...]
>>> Basavaraj Natikar (9):
>>>   iio: hid-sensor-als: Use channel index to support more hub attributes
>>>   iio: Add channel type light color temperature
>>>   iio: hid-sensor-als: Add light color temperature support
>>>   HID: amd_sfh: Add support for light color temperature
>>>   HID: amd_sfh: Add support for SFH1.1 light color temperature
>>>   iio: Add channel type for chromaticity
>>>   iio: hid-sensor-als: Add light chromaticity support
>>>   HID: amd_sfh: Add light chromaticity support
>>>   HID: amd_sfh: Add light chromaticity for SFH1.1  
>>
>> This series is breaking probing of hid-sensor-als on Framework 13 AMD
>> laptops [0].
>> The problem is that the patches require hid-sensors-als sensors to also
>> report chromaticity and color temparature which they don't.
> Gah.  Missed that in review.  Sorry about that and thanks for digging into
> this.
>>
>> When I remove the 'if (ret < 0) return ret;' checks in
>> als_parse_report() probing works and the illuminance/intensity channels
>> that show up behave as expected.
>> Unfortunately this still leaves behind a bunch of unusable channels.
>> A nice fix would be to have something like sysfs/hwmon .is_visible()
>> callback but that's not supported by IIO.
> 
> It's tricky to do because there is no simple association between
> what is registered as channels and the resulting attribute.  We could probably
> make it work, but not a simple thing to do.
> 
>>
>> One aproach would be to detect the usable channels in als_parse_report()
>> and then adapt the indio_dev->channels based on that information.
>>
>> [0] https://bugzilla.kernel.org/show_bug.cgi?id=218223
> 
> Agreed that adapting the channels is the way to go.
> Easiest option probably to set the relevant masks to 0 if the chromacity and
> temp channels aren't there + set their scan index values to -1.
> That 'should' suppress any attributes being created.
> Having a gap in scan indexes is common anyway so any userspace should cope
> with the timestamp being after a gap.
> 
> Alternatives would be to rebuild the chan_spec array to not have the entries,
> or pass in and fill in two copies of the array, picking the relevant one only
> on discovering if the temp and chromacity channels are present.
> 
> Jonathan
> 
>>
>> #regzbot introduced: 5f05285df691b1e82108eead7165feae238c95ef
>> #regzbot monitor: https://bugzilla.kernel.org/show_bug.cgi?id=218223
>>
> 
> 
> 

