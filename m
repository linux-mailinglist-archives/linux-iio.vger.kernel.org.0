Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6989CD8A4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfJFSij (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 14:38:39 -0400
Received: from vern.gendns.com ([98.142.107.122]:42564 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbfJFSij (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 14:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EB7HgQCd6wfHbcV/vGVRoCbCpG0HC8nsMy/oBEd1URQ=; b=0vzoW+jm1B3XKAvl9MDT9KBTt1
        owxlfy79uyVQco2v1xHDwo2GTYPtMx6pjhSOHOZ2DTJKlPLjeENuHuf4YdspzMtk+2fa9NHlMTAnW
        9Vmmjy8osDo/GebfC0UPRe0Ng4+khLlB+0LMOIepWaX9ERQ7dYoDtZ1Wc6FMHlpj4dTVpL6cx417R
        8NbK693FPbVQQ3YpUElxr5utVk26R+TDXWO5BY7rbXHmpfYMpJlZkL/DwBdZdbroAemDDl+MxAdMJ
        sn5KtiK8VZ2P+HBOLT4q2Sc37Lo5+WJBCJohH88UBclmAYSQQnPfPhQUzmNhxeeSAfVGIB8IyNUIo
        tw4Kut6A==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:54518 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <david@lechnology.com>)
        id 1iHBQR-0001Yn-Dn; Sun, 06 Oct 2019 14:38:35 -0400
Subject: Re: [PATCH v4 1/2] counter: Simplify the count_read and count_write
 callbacks
To:     William Breathitt Gray <vilhelm.gray@gmail.com>, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org
References: <cover.1570377521.git.vilhelm.gray@gmail.com>
 <7c129bd95675412e21c7a54e366e21723cac94ea.1570377521.git.vilhelm.gray@gmail.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <110c2460-f440-e36d-7975-61c53a94208d@lechnology.com>
Date:   Sun, 6 Oct 2019 13:38:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7c129bd95675412e21c7a54e366e21723cac94ea.1570377521.git.vilhelm.gray@gmail.com>
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
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/6/19 11:03 AM, William Breathitt Gray wrote:
> The count_read and count_write callbacks are simplified to pass val as
> unsigned long rather than as an opaque data structure. The opaque
> counter_count_read_value and counter_count_write_value structures,
> counter_count_value_type enum, and relevant counter_count_read_value_set
> and counter_count_write_value_get functions, are removed as they are no
> longer used.
> 
> Cc: David Lechner <david@lechnology.com>
> Cc: Patrick Havelange <patrick.havelange@essensium.com>
> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

Acked-by: David Lechner <david@lechnology.com>

