Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855C7AD6D3
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbfIIK1D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 06:27:03 -0400
Received: from first.geanix.com ([116.203.34.67]:50660 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfIIK1D (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 06:27:03 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 523F02D7;
        Mon,  9 Sep 2019 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568024793; bh=jFcs1OtpPRoMxPsyjvdnW3gXzs2esSSIG3gAzZUPBVs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=QvHpHTSVwUMgLvwrvdq64rqOA7HHNmGGS/fpHhlo2p2nlCzvFxWlXDDgsb9izkHNB
         iHZEpPE8Yd0SC+jsDOykg9/E1kExON2zylleHFiZ7Lie6q5UqYfQwTqLbtD5RNztQV
         Q+qZS+B0tAbm23Amn1Pj61eimDw7j7Tylg8LbUPfOj6orY6pA/pXqMwvU4RTGlt2NN
         JWl8xnRtJ+hWQZAu16pq7xNv+JvrJg6Q9n+5jFNenumKCKgmFC7qKh0tVYbJmAO5Kh
         0quCVGMVJPFhNmP1mKo7tI/qd9NbLp/sV1SPc+N4okzR9CW72Au03IYCia2uVvpwDn
         7TInmuVe7nI5Q==
Subject: Re: [PATCH v5 2/6] iio: imu: st_lsm6dsx: add motion events
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190909094506.51792-1-sean@geanix.com>
 <20190909094506.51792-2-sean@geanix.com>
 <20190909102117.GA2990@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <4e87bfae-ea15-a325-b4eb-232e6a370581@geanix.com>
Date:   Mon, 9 Sep 2019 12:26:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190909102117.GA2990@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 77834cc0481d
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 09/09/2019 12.21, Lorenzo Bianconi wrote:
> You defined wakeup_src_{w,y,z}_mask in patch 5/6 and you are using them here. Please do not do so since you are breaking 'git bisect'
> 
> Regards,
> Lorenzo

My bad, will update in v6 :)

Will move the device sensor definitions to 5/6, so we avoid
"warning: variable ‘**’ set but not used"

/Sean
