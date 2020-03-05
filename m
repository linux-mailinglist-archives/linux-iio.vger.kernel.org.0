Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA217A57E
	for <lists+linux-iio@lfdr.de>; Thu,  5 Mar 2020 13:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCEMnK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Mar 2020 07:43:10 -0500
Received: from www381.your-server.de ([78.46.137.84]:39352 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgCEMnK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Mar 2020 07:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7WrM2w+Spkm40Ar8dDt2aeThFbKRXodYzorwjvvpeoE=; b=kLRRJFhtSleNZQh8uJxuRUh0Gt
        mrg7DndD6muHeQdQQEbiZBTFymKeh8RwjjUzNCp6ztIZsZQ73Ypj23v+lAMBaeiLF5Bf3Iq8HUMoh
        tgRsnshB2Th2Ily2ixXUSN2YfSFafoM3Xe4zIY1dLYna3SUmTw9uMYPSdUEyKyJbzsZIVlcNrg2Lg
        zZKcul/ybk+tgr1m4uNxgt+qpOjWmk7igrBbTzWr8SGFh2pNMQMm8eBhVB6HgarAr7xS+lRenJweF
        ZhQ1ujjJjDMkkxRqdgJJrjgu6Ho+lyTQhwv9FuCM1qchpijqq7J9j4s9ooHq4WJ3VZxZAgMTKmmFk
        puO8/KzQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1j9pqD-0000yM-8t; Thu, 05 Mar 2020 13:43:05 +0100
Received: from [93.104.100.159] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1j9pqC-000HxZ-Sa; Thu, 05 Mar 2020 13:43:04 +0100
Subject: Re: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
Cc:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20200225124152.270914-1-nuno.sa@analog.com>
 <20200225124152.270914-6-nuno.sa@analog.com>
 <20200303211045.31f977bb@archlinux>
 <9b9e18f279edbcb60122a0b0d4c067975868194a.camel@analog.com>
 <63b5c766-78a2-59c4-6efb-3eb35031a351@metafoo.de>
 <3bdae6c113381c7dd0645b7b98c67fac734b92ab.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <13e355c6-af60-772a-92ec-aff17d0255ee@metafoo.de>
Date:   Thu, 5 Mar 2020 13:43:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3bdae6c113381c7dd0645b7b98c67fac734b92ab.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25741/Wed Mar  4 15:15:26 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/5/20 1:27 PM, Sa, Nuno wrote:
>
>> In my opinion there is should not be a difference in the userspace
>> interface for chips that do support 32-bit burst and those that
>> don't.
>> For devices that don't support 32-bit burst it should be emulated by
>> reading the LSB bits registers manually.
> Hmm. In terms of interface I think there is no difference. We always
> report 32bits channels (for accel and gyro). However, what we do right
> know is just to set the LSB to 0 if burst32 is not supported. So, we
> can be just ignoring the LSB bits if they are being used...

What I meant was that somebody might still want to get the full 32-bit 
values in buffered mode, even if the device does not support burst32. In 
that case you can first do a 16-bit burst read to get the MSBs and then 
do manual reads of all the LSB registers and then put both into the buffer.

- Lars

