Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3499335103A
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 09:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhDAHkg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 03:40:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36556 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbhDAHjy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 03:39:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210401073948euoutp022ecdf61813a579fc01b3d0f1cfae7fae~xq-AMf5xt1572715727euoutp02f
        for <linux-iio@vger.kernel.org>; Thu,  1 Apr 2021 07:39:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210401073948euoutp022ecdf61813a579fc01b3d0f1cfae7fae~xq-AMf5xt1572715727euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617262788;
        bh=ouCHkB7n4Z7YTm7nk0hIoMZxgsOAqRU0gJMPhxBLnTs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=izCy6uyZeQy40gbaZjFdGcOxitcZ477oC+yrYjKqQfIaPnUaOKJFWTlpN7Q0DG7Ab
         8GRpmjWp3e4PQAohuNqMDMkHXRmj/lCVI1oQX3LPiJpnzNofGo8I+JfC4W+z9ifdpF
         5DKE23j8S40TjN7YKM3UN8d62BWNXFqZHi3JfMuc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210401073948eucas1p1ffca07934137ab35efa845788034c12d~xq_-_n7aY1850918509eucas1p1L;
        Thu,  1 Apr 2021 07:39:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 89.70.09452.4C875606; Thu,  1
        Apr 2021 08:39:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210401073947eucas1p2c7f672475bce79dea00e9398cc562073~xq_-i6EVV2938829388eucas1p2U;
        Thu,  1 Apr 2021 07:39:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210401073947eusmtrp23637a11e329b89a415b7f653f7f1a4c4~xq_-iOhzU2984229842eusmtrp2j;
        Thu,  1 Apr 2021 07:39:47 +0000 (GMT)
X-AuditID: cbfec7f2-a9fff700000024ec-73-606578c4183b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8E.DE.08696.3C875606; Thu,  1
        Apr 2021 08:39:47 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210401073947eusmtip133ab252434ed3a78a6ed8bfd76956d68~xq__39WEV2618026180eusmtip1H;
        Thu,  1 Apr 2021 07:39:47 +0000 (GMT)
Subject: Re: [PATCH v6 14/24] iio: buffer: wrap all buffer attributes into
 iio_dev_attr
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        nuno.sa@analog.com, dragos.bogdan@analog.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <0d532b50-57aa-c8c2-e140-33cd07a63ce3@samsung.com>
Date:   Thu, 1 Apr 2021 09:39:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210215104043.91251-15-alexandru.ardelean@analog.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7pHKlITDN43iVv8v/ae0aLh4iQm
        iwdNq5gslkyez2ox78g7FovLu+awWUw4vJndYtMNfwcOj1dXHT02repk81jy5hCrx+dNcgEs
        UVw2Kak5mWWpRfp2CVwZOz+cYyzoLax4+fk/ewNjT0wXIyeHhICJxPae/WxdjFwcQgIrGCW+
        LrjLCOF8YZRYuHM7O4TzmVHi6u15zF2MHGAt00+IQMSXM0rs/v4Wqv0jo8SFya1sIEXCApES
        71uMQFaICBRKbF40lxXEZhYoljh++QmYzSZgKNH1tosNxOYVsJO4tGQSI4jNIqAisXHzHiYQ
        W1QgSWLpo3+MEDWCEidnPmEBsTkFXCROfL3CCDFTXqJ562xmCFtc4taT+Uwg90gI3OCQ+Hh8
        BzPEny4SB/ZPZIGwhSVeHd/CDmHLSPzfCdPQzCjx8Nxadginh1HictMMRogqa4k7536BfcYs
        oCmxfpc+RNhR4sP0JlZIqPBJ3HgrCHEEn8SkbdOhgcUr0dEmBFGtJjHr+Dq4tQcvXGKewKg0
        C8lrs5C8MwvJO7MQ9i5gZFnFKJ5aWpybnlpsmJdarlecmFtcmpeul5yfu4kRmH5O/zv+aQfj
        3Fcf9Q4xMnEwHmKU4GBWEuEVPpCYIMSbklhZlVqUH19UmpNafIhRmoNFSZx31ew18UIC6Ykl
        qdmpqQWpRTBZJg5OqQamudJdIbnPjf/3cBq/Ujwxk/XRqoqud4v+ldVazvB/z6yw1ithYVV0
        TmT/0uaJGnZO4l47935xS3Ritfn3ocu7m0c4dNvS9d0TVDd/MRBZ6PNhR8Tdt6cEDCMvb1bZ
        x7bOwPf/mmyFCrGi/DflLnISz3k2PNefv+/Cr2rBDVzO7o5Vseybnpa49qe9OFJmFHl6RkH+
        6YPGa/L3fZtxsWhWfk146v3j4cfmRQeEvHcVaV6+0azIZuHcPW+dFL5/ujnnZP3WWONVPK+D
        pnOdV48yjdt9SeSt5ve1tauM/XdJ9UhfuC9o/qOx/f/k4hTz3ee/71rxx5lpeopUw+t7ml/0
        /JlFef7Pvd3RNeWln0iXEktxRqKhFnNRcSIA68Sgy64DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xu7qHK1ITDLb9NLb4f+09o0XDxUlM
        Fg+aVjFZLJk8n9Vi3pF3LBaXd81hs5hweDO7xaYb/g4cHq+uOnpsWtXJ5rHkzSFWj8+b5AJY
        ovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQydn44
        x1jQW1jx8vN/9gbGnpguRg4OCQETieknRLoYuTiEBJYySpx5fZmxi5ETKC4jcXJaAyuELSzx
        51oXG0TRe0aJ73ObWECahQUiJd63GIGYIgKFEhsXeYGYzALFEhcbxUA6hQRqJHY3fgWbyCZg
        KNH1FmQKJwevgJ3EpSWTwOIsAioSGzfvYQKxRQWSJNp2z2SHqBGUODnzCQuIzSngInHi6xWw
        emYBM4l5mx8yQ9jyEs1bZ0PZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6x
        kV5xYm5xaV66XnJ+7iZGYKRtO/Zzyw7Gla8+6h1iZOJgPMQowcGsJMIrfCAxQYg3JbGyKrUo
        P76oNCe1+BCjKdA/E5mlRJPzgbGeVxJvaGZgamhiZmlgamlmrCTOa3JkTbyQQHpiSWp2ampB
        ahFMHxMHp1QDU0O7j/aLo7vn++hL+N1fxbaT1/7QhiLW5ZeWCEglez2eIe1e/q7d74fRVUVz
        eZYl+9aulDLnlCp57Pasab2Mr/YXXw2e0OqStRIfEnq7Z/AK2p/oklrKJ5igaDLpzfNq91OT
        DyQa1TPUJH7T3PJ/940dAt8Fou66Kfrc7vf56Lq0Ty3kHdcK3s7J/J/u5jw+oh2+ZfP5ur6E
        6HPfHmz+63O59une8Ed5mvwuZzN3vgo1EDO6cOIRy7l1RcvyjK4G/Yp01k+N/uE0d1OQWMTS
        jbMW75vubj2bs95tyq4Nl1ar8PzhUxH5rfRGf/J51v97X19Kjpu9+aS+wZTr3+JtS3pMiz4f
        z6lR1W1LOWyYoMRSnJFoqMVcVJwIADBIF0Q9AwAA
X-CMS-MailID: 20210401073947eucas1p2c7f672475bce79dea00e9398cc562073
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210401073947eucas1p2c7f672475bce79dea00e9398cc562073
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210401073947eucas1p2c7f672475bce79dea00e9398cc562073
References: <20210215104043.91251-1-alexandru.ardelean@analog.com>
        <20210215104043.91251-15-alexandru.ardelean@analog.com>
        <CGME20210401073947eucas1p2c7f672475bce79dea00e9398cc562073@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi

On 15.02.2021 11:40, Alexandru Ardelean wrote:
> This change wraps all buffer attributes into iio_dev_attr objects, and
> assigns a reference to the IIO buffer they belong to.
>
> With the addition of multiple IIO buffers per one IIO device, we need a way
> to know which IIO buffer is being enabled/disabled/controlled.
>
> We know that all buffer attributes are device_attributes. So we can wrap
> them with a iio_dev_attr types. In the iio_dev_attr type, we can also hold
> a reference to an IIO buffer.
> So, we end up being able to allocate wrapped attributes for all buffer
> attributes (even the one from other drivers).
>
> The neat part with this mechanism, is that we don't need to add any extra
> cleanup, because these attributes are being added to a dynamic list that
> will get cleaned up via iio_free_chan_devattr_list().
>
> With this change, the 'buffer->scan_el_dev_attr_list' list is being renamed
> to 'buffer->buffer_attr_list', effectively merging (or finalizing the
> merge) of the buffer/ & scan_elements/ attributes internally.
>
> Accessing these new buffer attributes can now be done via
> 'to_iio_dev_attr(attr)->buffer' inside the show/store handlers.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

This patch landed recently in linux-next as commit 15097c7a1adc ("iio: 
buffer: wrap all buffer attributes into iio_dev_attr"). Sadly it causes 
a regression and triggers the lock debuging warning:

ak8975 9-000c: mounting matrix not found: using identity...
ak8975 9-000c: supply vdd not found, using dummy regulator
ak8975 9-000c: supply vid not found, using dummy regulator
BUG: key cf40d08c has not been registered!
------------[ cut here ]------------
WARNING: CPU: 2 PID: 1 at kernel/locking/lockdep.c:4686 
__kernfs_create_file+0x7c/0xfc
DEBUG_LOCKS_WARN_ON(1)
Modules linked in:
CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc2-00153-g15097c7a1adc 
#2828
Hardware name: Samsung Exynos (Flattened Device Tree)
[<c011170c>] (unwind_backtrace) from [<c010cf74>] (show_stack+0x10/0x14)
[<c010cf74>] (show_stack) from [<c0b48650>] (dump_stack+0xa4/0xc4)
[<c0b48650>] (dump_stack) from [<c01274c8>] (__warn+0x118/0x11c)
[<c01274c8>] (__warn) from [<c0127544>] (warn_slowpath_fmt+0x78/0xbc)
[<c0127544>] (warn_slowpath_fmt) from [<c038db90>] 
(__kernfs_create_file+0x7c/0xfc)
[<c038db90>] (__kernfs_create_file) from [<c038e870>] 
(sysfs_add_file_mode_ns+0xa0/0x1cc)
[<c038e870>] (sysfs_add_file_mode_ns) from [<c038f4e0>] 
(internal_create_group+0x138/0x3f4)
[<c038f4e0>] (internal_create_group) from [<c038fd64>] 
(internal_create_groups+0x48/0x88)
[<c038fd64>] (internal_create_groups) from [<c06a8754>] 
(device_add+0x2e4/0x7ec)
[<c06a8754>] (device_add) from [<c02e46a0>] (cdev_device_add+0x48/0x80)
[<c02e46a0>] (cdev_device_add) from [<c08db1a4>] 
(__iio_device_register+0x670/0x7c0)
[<c08db1a4>] (__iio_device_register) from [<c08e2efc>] 
(ak8975_probe+0x3a4/0x584)
[<c08e2efc>] (ak8975_probe) from [<c082e120>] (i2c_device_probe+0x234/0x2a4)
[<c082e120>] (i2c_device_probe) from [<c06abea4>] (really_probe+0x1d4/0x4ec)
[<c06abea4>] (really_probe) from [<c06ac234>] 
(driver_probe_device+0x78/0x1d8)
[<c06ac234>] (driver_probe_device) from [<c06ac74c>] 
(device_driver_attach+0x58/0x60)
[<c06ac74c>] (device_driver_attach) from [<c06ac850>] 
(__driver_attach+0xfc/0x160)
[<c06ac850>] (__driver_attach) from [<c06a9e58>] 
(bus_for_each_dev+0x6c/0xb8)
[<c06a9e58>] (bus_for_each_dev) from [<c06aaf90>] 
(bus_add_driver+0x170/0x20c)
[<c06aaf90>] (bus_add_driver) from [<c06ad6c8>] (driver_register+0x78/0x10c)
[<c06ad6c8>] (driver_register) from [<c082f0d4>] 
(i2c_register_driver+0x3c/0xac)
[<c082f0d4>] (i2c_register_driver) from [<c0102434>] 
(do_one_initcall+0x88/0x430)
[<c0102434>] (do_one_initcall) from [<c11010d4>] 
(kernel_init_freeable+0x190/0x1e0)
[<c11010d4>] (kernel_init_freeable) from [<c0b4c564>] 
(kernel_init+0x8/0x118)
[<c0b4c564>] (kernel_init) from [<c010011c>] (ret_from_fork+0x14/0x38)
Exception stack(0xc1d09fb0 to 0xc1d09ff8)
9fa0:                                     00000000 00000000 00000000 
00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
irq event stamp: 485619
hardirqs last  enabled at (485619): [<c01a51fc>] console_unlock+0x500/0x648
hardirqs last disabled at (485618): [<c01a51e0>] console_unlock+0x4e4/0x648
softirqs last  enabled at (484774): [<c0101790>] __do_softirq+0x528/0x63c
softirqs last disabled at (484769): [<c0130a38>] irq_exit+0x1f4/0x1fc
---[ end trace 21850020cbfb3350 ]---

The above warning is probably caused by copying struct device_attribute 
objects in iio_buffer_wrap_attr() without re-initializing 
spinlocks/mutexes. Locks debuging depends on the spinlock/mutex 
initializers, which register them (as absolute value of the pointer to 
them) to the debugging engine. After copying the structures, the objects 
don't match the pointers they were registered. I didn't have time to 
analyze it further and find which object/lock is triggering this though.

> ---
>   drivers/iio/industrialio-buffer.c | 76 ++++++++++++++++++++-----------
>   include/linux/iio/buffer_impl.h   |  4 +-
>   2 files changed, 52 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index e6edec3bcb73..8dc140f13b99 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -253,8 +253,7 @@ static ssize_t iio_scan_el_show(struct device *dev,
>   				char *buf)
>   {
>   	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   
>   	/* Ensure ret is 0 or 1. */
>   	ret = !!test_bit(to_iio_dev_attr(attr)->address,
> @@ -367,8 +366,8 @@ static ssize_t iio_scan_el_store(struct device *dev,
>   	int ret;
>   	bool state;
>   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
>   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	struct iio_buffer *buffer = this_attr->buffer;
>   
>   	ret = strtobool(buf, &state);
>   	if (ret < 0)
> @@ -402,8 +401,7 @@ static ssize_t iio_scan_el_ts_show(struct device *dev,
>   				   struct device_attribute *attr,
>   				   char *buf)
>   {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   
>   	return sprintf(buf, "%d\n", buffer->scan_timestamp);
>   }
> @@ -415,7 +413,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
>   {
>   	int ret;
>   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   	bool state;
>   
>   	ret = strtobool(buf, &state);
> @@ -448,7 +446,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>   				     IIO_SEPARATE,
>   				     &indio_dev->dev,
>   				     buffer,
> -				     &buffer->scan_el_dev_attr_list);
> +				     &buffer->buffer_attr_list);
>   	if (ret)
>   		return ret;
>   	attrcount++;
> @@ -460,7 +458,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>   				     0,
>   				     &indio_dev->dev,
>   				     buffer,
> -				     &buffer->scan_el_dev_attr_list);
> +				     &buffer->buffer_attr_list);
>   	if (ret)
>   		return ret;
>   	attrcount++;
> @@ -473,7 +471,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>   					     0,
>   					     &indio_dev->dev,
>   					     buffer,
> -					     &buffer->scan_el_dev_attr_list);
> +					     &buffer->buffer_attr_list);
>   	else
>   		ret = __iio_add_chan_devattr("en",
>   					     chan,
> @@ -483,7 +481,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>   					     0,
>   					     &indio_dev->dev,
>   					     buffer,
> -					     &buffer->scan_el_dev_attr_list);
> +					     &buffer->buffer_attr_list);
>   	if (ret)
>   		return ret;
>   	attrcount++;
> @@ -495,8 +493,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
>   				      struct device_attribute *attr,
>   				      char *buf)
>   {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   
>   	return sprintf(buf, "%d\n", buffer->length);
>   }
> @@ -506,7 +503,7 @@ static ssize_t iio_buffer_write_length(struct device *dev,
>   				       const char *buf, size_t len)
>   {
>   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   	unsigned int val;
>   	int ret;
>   
> @@ -538,8 +535,7 @@ static ssize_t iio_buffer_show_enable(struct device *dev,
>   				      struct device_attribute *attr,
>   				      char *buf)
>   {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   
>   	return sprintf(buf, "%d\n", iio_buffer_is_active(buffer));
>   }
> @@ -1154,7 +1150,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
>   	int ret;
>   	bool requested_state;
>   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   	bool inlist;
>   
>   	ret = strtobool(buf, &requested_state);
> @@ -1183,8 +1179,7 @@ static ssize_t iio_buffer_show_watermark(struct device *dev,
>   					 struct device_attribute *attr,
>   					 char *buf)
>   {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   
>   	return sprintf(buf, "%u\n", buffer->watermark);
>   }
> @@ -1195,7 +1190,7 @@ static ssize_t iio_buffer_store_watermark(struct device *dev,
>   					  size_t len)
>   {
>   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   	unsigned int val;
>   	int ret;
>   
> @@ -1228,8 +1223,7 @@ static ssize_t iio_dma_show_data_available(struct device *dev,
>   						struct device_attribute *attr,
>   						char *buf)
>   {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct iio_buffer *buffer = to_iio_dev_attr(attr)->buffer;
>   
>   	return sprintf(buf, "%zu\n", iio_buffer_data_available(buffer));
>   }
> @@ -1254,6 +1248,26 @@ static struct attribute *iio_buffer_attrs[] = {
>   	&dev_attr_data_available.attr,
>   };
>   
> +#define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
> +
> +static struct attribute *iio_buffer_wrap_attr(struct iio_buffer *buffer,
> +					      struct attribute *attr)
> +{
> +	struct device_attribute *dattr = to_dev_attr(attr);
> +	struct iio_dev_attr *iio_attr;
> +
> +	iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
> +	if (!iio_attr)
> +		return NULL;
> +
> +	iio_attr->buffer = buffer;
> +	memcpy(&iio_attr->dev_attr, dattr, sizeof(iio_attr->dev_attr));
> +
> +	list_add(&iio_attr->l, &buffer->buffer_attr_list);
> +
> +	return &iio_attr->dev_attr.attr;
> +}
> +
>   static int iio_buffer_register_legacy_sysfs_groups(struct iio_dev *indio_dev,
>   						   struct attribute **buffer_attrs,
>   						   int buffer_attrcount,
> @@ -1329,7 +1343,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>   	}
>   
>   	scan_el_attrcount = 0;
> -	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> +	INIT_LIST_HEAD(&buffer->buffer_attr_list);
>   	channels = indio_dev->channels;
>   	if (channels) {
>   		/* new magic */
> @@ -1376,9 +1390,19 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>   
>   	buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
>   
> -	attrn = buffer_attrcount;
> +	for (i = 0; i < buffer_attrcount; i++) {
> +		struct attribute *wrapped;
> +
> +		wrapped = iio_buffer_wrap_attr(buffer, attr[i]);
> +		if (!wrapped) {
> +			ret = -ENOMEM;
> +			goto error_free_scan_mask;
> +		}
> +		attr[i] = wrapped;
> +	}
>   
> -	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
> +	attrn = 0;
> +	list_for_each_entry(p, &buffer->buffer_attr_list, l)
>   		attr[attrn++] = &p->dev_attr.attr;
>   
>   	buffer->buffer_group.name = kasprintf(GFP_KERNEL, "buffer%d", index);
> @@ -1412,7 +1436,7 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>   error_free_scan_mask:
>   	bitmap_free(buffer->scan_mask);
>   error_cleanup_dynamic:
> -	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> +	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
>   
>   	return ret;
>   }
> @@ -1443,7 +1467,7 @@ static void __iio_buffer_free_sysfs_and_mask(struct iio_buffer *buffer)
>   	bitmap_free(buffer->scan_mask);
>   	kfree(buffer->buffer_group.name);
>   	kfree(buffer->buffer_group.attrs);
> -	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
> +	iio_free_chan_devattr_list(&buffer->buffer_attr_list);
>   }
>   
>   void iio_buffer_free_sysfs_and_mask(struct iio_dev *indio_dev)
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index 3e555e58475b..41044320e581 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -97,8 +97,8 @@ struct iio_buffer {
>   	/* @scan_timestamp: Does the scan mode include a timestamp. */
>   	bool scan_timestamp;
>   
> -	/* @scan_el_dev_attr_list: List of scan element related attributes. */
> -	struct list_head scan_el_dev_attr_list;
> +	/* @buffer_attr_list: List of buffer attributes. */
> +	struct list_head buffer_attr_list;
>   
>   	/*
>   	 * @buffer_group: Attributes of the new buffer group.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

