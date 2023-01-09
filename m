Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D84E661F7B
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 08:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjAIHyJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 02:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjAIHyI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 02:54:08 -0500
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AF6DF3B
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 23:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
        MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=jaYJfmWaec2O9BrboewKFlPWTKoDaFgW7yXlE547wAw=; b=WG5qLOCiyyuXnncvR09NK9pKcJ
        84/2cVIdbZbXYtXeLtNosII9BXRYL1ziAVLA4Go1zA4O9WSl9rz/4N3HRW0Luuv3n2Kz0/Z3munpA
        KGfLzdeYN12i5IF5hQsKzrTy5VXTt9pKSaYuj7XhEf1MyauQES5Xp+FjN1vKu19BQtuqRyD5sK7oq
        15bsbBSs2Z7yikB+6CDiOrowkLZPZJfmfhvxVh/UkqY0p12W4TDWZk25OAzUs3OyWSKzJG2OeSdIA
        ugCJQn/m+M5U/4N8qYXJ8M48y3sL/rVWC+QTEw0hnOlQaXvp5cniGftTGaCShF5m8dAhQ7V2M4tcF
        XU11d6Kg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1pEmyr-000NBt-M8; Mon, 09 Jan 2023 08:54:05 +0100
Received: from [185.17.218.86] (helo=[192.168.64.74])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1pEmyr-000T1d-GK; Mon, 09 Jan 2023 08:54:05 +0100
Message-ID: <3b268231-7115-d354-4258-9e928c2fa15e@geanix.com>
Date:   Mon, 9 Jan 2023 08:54:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Subject: fxls8962af: RTC and NTP
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.7/26775/Sun Jan  8 09:52:41 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan and list,

We are getting some weird timestamps (with fxls8962af) in the iio 
buffers when time is set back by NTP.

Here I have dumped old_timestamp, timestamp from the 
fxls8962af_fifo_flush():
old_timestamp 1673008488434717043, timestamp 1673008489457042043
*old_timestamp 1673008489457042043, timestamp 1673008485198504719*
old_timestamp 1673008485198504719, timestamp 1673008486220571510

Time is set back in the middle data set, so the sample timestamp looks like:
tstamp0 3091988802491735451
tstamp1 4510969115526428858
tstamp2 5929949428561122265
tstamp3 7348929741595815672
tstamp4 8767910054630509079
tstamp5 -8259853706044349130
tstamp6 -6840873393009655723
tstamp7 -5421893079974962316
tstamp8 -4002912766940268909
tstamp9 -2583932453905575502
tstamp10 -1164952140870882095
tstamp11 254028172163811312
tstamp12 1673008485198504719

Possible solutions?
Could we store the sample time from the last collected data set?
And use that if old_timestamp > timestamp?

Or do you have any other idea's?

/Sean
