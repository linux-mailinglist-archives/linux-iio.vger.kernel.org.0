Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDDAD2060D
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfEPLqV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 07:46:21 -0400
Received: from first.geanix.com ([116.203.34.67]:58892 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728168AbfEPLqR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 May 2019 07:46:17 -0400
Received: from [192.168.100.161] (unknown [95.138.208.137])
        by first.geanix.com (Postfix) with ESMTPSA id A562E9C6;
        Thu, 16 May 2019 11:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1558007159; bh=48NKzE1/3iP61tLwlRVE1PgLB30RBeybnWDZN7lLIFg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j6A058Td5vwyWp9Uu5PiUeWvg+sHjuUmrLEX/jNQ8NoFB2S9VFoOPP7/pI74AqYPY
         z7od0sDUk4E1F9zAhnnJZLYM5iHwfTlbuuYrCoiXmdm7PNnONbxWN6UjuBaqWW1YD+
         RJIJ9mTIOxQHyHfSf7O0BQjKZjE12J6N3DlnkwI2G6Z3C/K6QJKmH+UaIxPdt+xMrY
         Kz5dtFkeBwFhoI/628a1EpP24Rj8ncT9PHmngHRuJV55ZDWwpXYhPN2Xw9Ke965neJ
         1eee83FOhpYBxnGJrCH162tQw9rcPgrw32Mbffg69lrGDVQA4fZvxin4suIOxQHP4+
         Ik9v/CMrwGtlA==
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: add iio trigger and buffer
 support
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        martin@geanix.com, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis CIOCCA <denis.ciocca@st.com>
References: <20190507080225.108000-1-sean@geanix.com>
 <20190507080225.108000-2-sean@geanix.com> <20190511123755.2d220233@archlinux>
 <20190511123054.GA14837@localhost.localdomain>
 <a8dc4bcc-b004-b287-2126-7c3b082dd3ba@geanix.com>
 <20190511170039.GA4547@localhost.localdomain>
From:   Sean Nyekjaer <sean@geanix.com>
Message-ID: <d2946e63-6814-6fe0-b268-486a5e68dcb9@geanix.com>
Date:   Thu, 16 May 2019 13:46:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190511170039.GA4547@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on 796779db2bec
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Please ignore this patchset.
The IRQ is indeed connected to our SoC

/Sean
