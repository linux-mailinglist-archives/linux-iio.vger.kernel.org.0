Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B6CA9ABD
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 08:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfIEGh7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 02:37:59 -0400
Received: from first.geanix.com ([116.203.34.67]:37996 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbfIEGh7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 02:37:59 -0400
Received: from [192.168.100.95] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id B256A62578;
        Thu,  5 Sep 2019 06:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567665467; bh=ooslwGUmbaszu9MhAQWuNDQEghCIlWpljFHDJnX/X6I=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=X5Uh+reRPNOaDWd+0IKKc7qtr/4gH1lEX0LJ7xr8i4Zn+KxN0flEvego5JFtD3ZSI
         1cmRq6WUCHMRFsv7pHSzf8mAP2HOPvsRBBembc8K4ScYsn+udn8kgosOZWJZKz+wKT
         sa1tvc8WO7PKtWMSnJDzmzhflzs2LCObXKjBjgbv/MRw0r5tHUMf7pgRM+u5Q0xO6Q
         FKLFkun4sPwshHx8MB5DlLzUbVMDbuPTydDgFE0iQgT6oUPLrUjQ3neHpe2LJYSP7F
         YBo1KwbgmXfCmq8y2ppaQ+SF0TjEjv+Ov+yxsdKBgUFLCNjBiYc9snU7lbAtBY9Xe5
         yMJu0DGPRTcMA==
Subject: Re: [PATCH v3 4/6] iio: imu: st_lsm6dsx: always enter interrupt
 thread
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-4-sean@geanix.com>
 <20190905063441.GA31578@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <a40bef10-8f82-e284-806e-4852abeb6400@geanix.com>
Date:   Thu, 5 Sep 2019 08:37:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905063441.GA31578@localhost.localdomain>
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



On 05/09/2019 08.34, Lorenzo Bianconi wrote:
> This chunck is unnecessary since read_fifo() will check number of available
> samples in the FIFO and moreover it is obviously broken since you are running
> st_lsm6dsx_read_fifo directly instead of using fifo_ops pointer.

Thanks for the review :-)

I have missed that, I have spend a lot of time rebasing "iio: imu: 
st_lsm6dsx: move interrupt thread to core".
It could be nice if that patch could be applied in the near future :-)

/Sean
