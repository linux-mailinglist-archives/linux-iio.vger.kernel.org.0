Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B28462FCB
	for <lists+linux-iio@lfdr.de>; Tue, 30 Nov 2021 10:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhK3JjD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 30 Nov 2021 04:39:03 -0500
Received: from first.geanix.com ([116.203.34.67]:37674 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235582AbhK3JjC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 30 Nov 2021 04:39:02 -0500
Received: from [IPV6:2a06:4004:10df:1:da27:a6d2:5305:fd0a] (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 89F52E1DE8;
        Tue, 30 Nov 2021 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1638264937; bh=xOJQ413BWJqdu9W4lbAZFrlPKyhB/iVKtjprlQKLVgw=;
        h=Date:To:Cc:From:Subject;
        b=Bl60cZ/I1mdUAUvs+bWizGZJB7eMt00ka1EAs64lsFpKWt04ax3L2a5mCR4+K9/cT
         UZno2CU6izWLUNjElnb/OeyRYQ5txzAxfx7W1CPZTbpmWGb0CMU79LlY78vUZ3p9uJ
         s0SsFWkOla8okn24kSNxHKBgC4ndXGxeKwxsObF4VFofrc05Dp+p/qxsLlvYEMnLva
         3ox9RCN/bdzMqUnMVY/OBIEeJsiL/bbdWNWdkRjHHw6B01mWbBiNPhVVIwkRFhtn8Z
         moV5BI+60+sfrpKzI5cQ870OnI4sr9F7vBpkA3471aWNmMuw9VrQbY5vjKo14pI91e
         HfxZaM5JMKnQQ==
Message-ID: <7295b3cb-c820-4057-42f2-83b807be627c@geanix.com>
Date:   Tue, 30 Nov 2021 10:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Content-Language: en-US
Cc:     linux-iio <linux-iio@vger.kernel.org>
From:   Sean Nyekjaer <sean@geanix.com>
Subject: st_lsm6dsx: AIS2IH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Hi Lorenzo,

Have you been looking at the AIS2IH, should it fit in the st_lsm6dsx driver?

Br,
Sean Nyekjaer
