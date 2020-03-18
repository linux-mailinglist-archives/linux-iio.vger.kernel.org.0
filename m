Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E7A18A897
	for <lists+linux-iio@lfdr.de>; Wed, 18 Mar 2020 23:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCRWvO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Mar 2020 18:51:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38228 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726619AbgCRWvO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Mar 2020 18:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584571873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OsT8y8UZFRfG+HGRJDP8qrLB9AX5R1GNyZr/HRuK41I=;
        b=GGgPeyRudFZnZVQ+04MB3UapVHUjqB2djnjAIZidMWCARzNR0Nc27o1bZBxW34kOBA/aQK
        H/jjqGJnVXrJ42wWay0K5d9WJYYFEBwYH6OBKjOmIpBn4xdU5Wf4SiFdVykvoS6y7ejE2a
        uH9mRKr5c4PXFRJwhKZr1oH3UrqcQyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-KMlfn90nOf2rypVQW7CKPg-1; Wed, 18 Mar 2020 18:51:09 -0400
X-MC-Unique: KMlfn90nOf2rypVQW7CKPg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7ADA107B7D7;
        Wed, 18 Mar 2020 22:51:07 +0000 (UTC)
Received: from elisabeth (unknown [10.40.208.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6D4C912AC;
        Wed, 18 Mar 2020 22:51:03 +0000 (UTC)
Date:   Wed, 18 Mar 2020 23:50:57 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        daniel.baluta@gmail.com, kieran.bingham@ideasonboard.com,
        lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 2/3] staging: iio: adc: ad7192:
 Correct macro names from SYNC to SINC
Message-ID: <20200318235057.4da5cd5c@elisabeth>
In-Reply-To: <4eaa90f120a24fd5f08338d0643ee8f215f169b1.1584557481.git.mh12gx2825@gmail.com>
References: <cover.1584557481.git.mh12gx2825@gmail.com>
        <4eaa90f120a24fd5f08338d0643ee8f215f169b1.1584557481.git.mh12gx2825@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Mar 2020 00:39:13 +0530
Deepak R Varma <mh12gx2825@gmail.com> wrote:

> Three macros include SYNC in their names which is a typo. Update those
> names to SINC. Change suggested by Lars-Peter Clausen.

There are tags for that, in particular:

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Fixes: 77f6a23092c0 ("staging: iio: adc: ad7192: Add low_pass_3db_filter_frequency")

Please keep an eye on messages from/to others on the outreachy-kernel
list, these topics are being discussed quite frequently.

> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> ---
>
> [...]

-- 
Stefano

