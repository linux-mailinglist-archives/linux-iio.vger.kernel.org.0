Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF18BAD7A7
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 13:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbfIILIE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 07:08:04 -0400
Received: from first.geanix.com ([116.203.34.67]:53020 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730331AbfIILIE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 07:08:04 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id AC7076E017;
        Mon,  9 Sep 2019 11:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568027255; bh=wzD8AUOdLkB/u/atVFk8mWjIR4LHk2RciILYt2dAFI0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EubVfuesKoXsahsAfWVqX/MwN2kKRiF8D9+dzKY+OYVxDOlTjThBE1INq70dSJBrS
         kXyEtkCqViJ98LVVoxAEFm2JnPRd+SiY5/1fJGw0rgWeQW+MXR/q7hcLE4iDISF2LG
         cg38Gh9v8lpJvuqfwg5FYjujQgdU98TrcMOWo8xcWlk0MWo4NlqAkdeyCfA9SduyAP
         5Xui9z84kgWT96cENZ4VEU8psi4T9yrkeAWbYRUQhgfPoSakcZFrZEjrG+7SL8Gasf
         TfRm0y29afK749EBfbQAbl2rhyRARGf0YCwfmpGIXDhsNU/PxzSYsMGuvnRys1ZjPy
         GY2J/QLADwpWQ==
Subject: Re: [PATCH v5.1 6/6] iio: imu: st_lsm6dsx: prohibit the use of events
 and buffered reads simultaneously
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190909094506.51792-6-sean@geanix.com>
 <20190909095618.70801-1-sean@geanix.com>
 <20190909104035.GB2990@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <445b8749-b1d2-5e98-f7db-8a91bf43ab33@geanix.com>
Date:   Mon, 9 Sep 2019 13:07:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909104035.GB2990@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 09/09/2019 12.40, Lorenzo Bianconi wrote:
> I_really_  do not think you are testing these patches since there are plenty of
> errors here:
> 
> 1- mutex_unlock instead of mutex_lock

Again, my bad :)

The error show quite quickly:
WARNING: bad unlock balance detected!

> 2- returning without releasing the lock
> 
> Please put more attention next time and test you patches

Will do...
Thanks for the review

/Sean
