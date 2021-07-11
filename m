Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7803C3D23
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jul 2021 16:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhGKOIa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Jul 2021 10:08:30 -0400
Received: from vern.gendns.com ([98.142.107.122]:37108 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232907AbhGKOI3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jul 2021 10:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=opiyXzz03XSvATCVRQY9c1WK7Xfz/7xyqkaDVHpblnA=; b=fUrBhWtbCVrd2/MswDdJf3BmcI
        gGdKTBwUzBrOarv9W9KDAElabrY2h4DzMS7WhUpPq0qqVdEICnlwj+hPFRRK2jDDWfg9xDV9FmASi
        qlUIpSImfp56d28SrY+WB4CrhtDId+3+LGSVDPZmR5powvHKj0EDfGw5j+G1pz/d8mpjXw5y9HF5i
        oRpK3aeSGWYPLHuP5Tk9HBl8+lDkw3IlkUJUa3qndZxMwyDQJORADABi2+cBXW3CsR1rKp8DJ6BzV
        jQlJlfpCfsGsiO/bkNQmylp9UgcW34SykCbPyrhmuQQbrxGYJj48RkRFrdr7rlypLPMJIew1OpD29
        4qdDwXDw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51930 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1m2a5R-003hqX-91; Sun, 11 Jul 2021 10:05:38 -0400
Subject: Re: [PATCH v12 12/17] tools/counter: Create Counter tools
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        kernel@pengutronix.de, a.fatoum@pengutronix.de,
        kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com, Pavel Machek <pavel@ucw.cz>
References: <cover.1625471640.git.vilhelm.gray@gmail.com>
 <e97aa3e529f54d5651df7edcc1b43a8157d9e9c3.1625471640.git.vilhelm.gray@gmail.com>
 <343a2bd3-38b7-7462-bc52-d3f6493bede0@lechnology.com>
 <YOrVy7Ba117s1maQ@shinobu>
From:   David Lechner <david@lechnology.com>
Message-ID: <56fb48ac-335d-f112-6370-38ad35ad72f0@lechnology.com>
Date:   Sun, 11 Jul 2021 09:05:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOrVy7Ba117s1maQ@shinobu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/11/21 6:28 AM, William Breathitt Gray wrote:
> On Sat, Jul 10, 2021 at 11:53:35AM -0500, David Lechner wrote:
>> On 7/5/21 3:19 AM, William Breathitt Gray wrote:

>>> +	{
>>> +		/* Component data: Count 0 count */
>>> +		.component.type = COUNTER_COMPONENT_COUNT,
>>> +		.component.scope = COUNTER_SCOPE_COUNT,
>>> +		.component.parent = 0,
>>> +		/* Event type: Index */
>>> +		.event = COUNTER_EVENT_INDEX,
>>> +		/* Device event channel 0 */
>>> +		.channel = 0,
>>> +	},
>>> +	{
>>> +		/* Component data: Count 1 count */
>>> +		.component.type = COUNTER_COMPONENT_COUNT,
>>> +		.component.scope = COUNTER_SCOPE_COUNT,
>>> +		.component.parent = 1,
>>> +		/* Event type: Index */
>>> +		.event = COUNTER_EVENT_INDEX,
>>> +		/* Device event channel 0 */
>>> +		.channel = 0,
>>> +	},
>>> +};
>>> +
>>> +int main(void)
>>> +{
>>> +	int fd;
>>> +	int ret;
>>> +	struct counter_event event_data[2];
>>> +
>>> +	fd = open("/dev/counter0", O_RDWR);
>>> +	if (fd == -1) {
>>> +		perror("Unable to open /dev/counter0");
>>> +		return -errno;
>>
>> errno is no longer valid after calling perror(). Since this
>> is example code, we can just return 1 instead (exit codes
>> positive number between 0 and 255 so -1 would be 255).
> 
> Ack.
> 
>>> +	}
>>> +
>>> +	ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches);
>>> +	if (ret == -1) {
>>> +		perror("Error adding watches[0]");
>>> +		return -errno;
>>> +	}
>>> +	ret = ioctl(fd, COUNTER_ADD_WATCH_IOCTL, watches + 1);
>>> +	if (ret == -1) {
>>> +		perror("Error adding watches[1]");
>>> +		return -errno;
>>> +	}
>>> +	ret = ioctl(fd, COUNTER_ENABLE_EVENTS_IOCTL);
>>> +	if (ret == -1) {
>>> +		perror("Error enabling events");
>>> +		return -errno;
>>> +	}
>>> +
>>> +	for (;;) {
>>> +		ret = read(fd, event_data, sizeof(event_data));
>>> +		if (ret == -1) {
>>> +			perror("Failed to read event data");
>>> +			return -errno;
>>> +		}
>>> +
>>> +		if (ret != sizeof(event_data)) {
>>> +			fprintf(stderr, "Failed to read event data\n");
>>> +			return -EIO;
>>> +		}
>>> +
>>> +		printf("Timestamp 0: %llu\tCount 0: %llu\n"
>>> +		       "Error Message 0: %s\n"
>>> +		       "Timestamp 1: %llu\tCount 1: %llu\n"
>>> +		       "Error Message 1: %s\n",
>>> +		       (unsigned long long)event_data[0].timestamp,
>>> +		       (unsigned long long)event_data[0].value,
>>> +		       strerror(event_data[0].status),
>>> +		       (unsigned long long)event_data[1].timestamp,
>>> +		       (unsigned long long)event_data[1].value,
>>> +		       strerror(event_data[1].status));
>>> +	}
>>
>> Aren't the Count 0 and Count 1 events independent? Why should we expect to
>> always get both events at the same time in the same order?
> 
> Watch 0 and Watch 1 are both triggered by the same event: a
> COUNTER_EVENT_INDEX event on device event channel 0. If we had set
> channel to 1 for Watch 1, then we would have two independent events, but
> in this case both Watches have their respective channel set to 0.

The thing that jumped out to me is that they have different parents.
But I guess I forgot that the event itself always has a scope of
device and that the component just says what value to record and
is otherwise independent of the event.

