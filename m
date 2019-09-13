Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC079B1A5A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 11:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387788AbfIMJAl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 05:00:41 -0400
Received: from first.geanix.com ([116.203.34.67]:49374 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387499AbfIMJAk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Sep 2019 05:00:40 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id 06B0215E2;
        Fri, 13 Sep 2019 08:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568365194; bh=eJuFKCry6jk0T1xt3a3V2US2F/b1zAkiMgx/j3zPpE0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EIVMCVQN3nno/QvX+gFvb3puTtN8V30pMzEBItlAWk6xbc3o0IiOmrs/iDlsNLB9c
         CiYPLZXjsJK5me2e91yOUoDMojgr2pA+ma3m9fpBYSiwM4VfEXP+i5BK5okKIc2Mgj
         5sHuHcwW/0Z9Fw/pR5jyIEhs6UNGhfNX6R7ipSe1D56ey+B3NKxVH9vjAYYnYg+2/e
         gycCXVcVsLkeT6Quyh0dR67HcklgF9R3OvC0SsdH4Q4p0ntKa9dxJhu5qwpldjwWBW
         6+g3jK1yxnckv1o4z7c9HpPajPvNN6sAJtWEJwhj0ffR1YZcKmL1u3fa5JjotTz5Jv
         6HX5elHUJB09w==
Subject: Re: [PATCH v7 3/5] iio: imu: st_lsm6dsx: add wakeup-source option
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190912070614.1144169-1-sean@geanix.com>
 <20190912070614.1144169-4-sean@geanix.com>
 <6eb3a60f-0712-4ad7-fe3c-fd76a3ea135f@geanix.com>
 <20190913082701.GA2698@localhost.localdomain>
 <66e35f99-780b-7063-37ad-3fb656a6dffc@geanix.com>
 <20190913085851.GB2698@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <575df7e7-4b25-fa9a-c723-669c4aca7b5f@geanix.com>
Date:   Fri, 13 Sep 2019 11:00:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190913085851.GB2698@localhost.localdomain>
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



On 13/09/2019 10.58, Lorenzo Bianconi wrote:
> Actually I have not tested, just compiled. Looking at the code seems fine.
> 
> Regards,
> Lorenzo

I'll post V8 with updated [PATCH 3/5] for Jonathan :-)

/Sean
