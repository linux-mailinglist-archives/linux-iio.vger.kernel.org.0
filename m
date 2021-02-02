Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F75930B7A7
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 07:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhBBGKW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 01:10:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58000 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBBGKV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 01:10:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11268up9016134;
        Tue, 2 Feb 2021 06:09:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=R3ef86ZzYS28dCIL/XwjP0Xm45d3pgoLxwNi4bOk11o=;
 b=QMBxY/aBuikDtlkJL7ltyCSq7wnLNFLKVcJwrZz+q5EswxyWtWrQnuDwsKy4pekZFQc3
 1fItSqYDYd+ZsqiGuent0/5XJGB7gInBnCE2ErT8OQHtRpyihesrG2Ql3AkHyTZ+4LNg
 kif1VT+YSt8pJzrXQnkt74egyQZtR0lvvWMN/ocDCVB/M5Vlmrhdqpy56Wpf/PUbaRYj
 7rAgapUUFPxZf7gL+U2cRq1fQeKFtZfxxiBIOvhIhUDNlyv5PijWf5QSfFOyt2JYFLR0
 /QI5YVzQliYkkOjwePA3OrB8JqwJLn//B20rqbijN0A28KiH5nImq2ejAf9KOYU/XO8d Hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36cydkrxpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 06:09:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11261SqT167668;
        Tue, 2 Feb 2021 06:07:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 36dh1ngham-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Feb 2021 06:07:17 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11267Gd3016861;
        Tue, 2 Feb 2021 06:07:16 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Feb 2021 22:07:15 -0800
Date:   Tue, 2 Feb 2021 09:07:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
        dragos.bogdan@analog.com, rafael@kernel.org,
        gregkh@linuxfoundation.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v3 06/11] iio: core: merge buffer/ & scan_elements/
 attributes
Message-ID: <20210202060705.GN2696@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KtWcatouGV9Nk9BU"
Content-Disposition: inline
In-Reply-To: <20210201145105.20459-7-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020042
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9882 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020043
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--KtWcatouGV9Nk9BU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alexandru,

url:    https://github.com/0day-ci/linux/commits/Alexandru-Ardelean/iio-core-buffer-add-support-for-multiple-IIO-buffers-per-IIO-device/20210201-233550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: arc-randconfig-m031-20210201 (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/iio/industrialio-buffer.c:1413 __iio_buffer_alloc_sysfs_and_mask() error: uninitialized symbol 'ret'.

vim +/ret +1413 drivers/iio/industrialio-buffer.c

e16e0a778fec8a Alexandru Ardelean 2020-09-17  1314  static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
418ff389a5a48a Alexandru Ardelean 2021-02-01  1315  					     struct iio_dev *indio_dev,
418ff389a5a48a Alexandru Ardelean 2021-02-01  1316  					     int index)
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1317  {
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1318  	struct iio_dev_attr *p;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1319  	struct attribute **attr;
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1320  	int ret, i, attrn, scan_el_attrcount, buffer_attrcount;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1321  	const struct iio_chan_spec *channels;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1322  
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1323  	buffer_attrcount = 0;
08e7e0adaa1720 Lars-Peter Clausen 2014-11-26  1324  	if (buffer->attrs) {
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1325  		while (buffer->attrs[buffer_attrcount] != NULL)
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1326  			buffer_attrcount++;
08e7e0adaa1720 Lars-Peter Clausen 2014-11-26  1327  	}
08e7e0adaa1720 Lars-Peter Clausen 2014-11-26  1328  
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1329  	scan_el_attrcount = 0;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1330  	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1331  	channels = indio_dev->channels;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1332  	if (channels) {
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1333  		/* new magic */
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1334  		for (i = 0; i < indio_dev->num_channels; i++) {
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1335  			if (channels[i].scan_index < 0)
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1336  				continue;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1337  
ff3f7e049aef92 Alexandru Ardelean 2020-04-24  1338  			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1339  							 &channels[i]);
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1340  			if (ret < 0)
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1341  				goto error_cleanup_dynamic;
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1342  			scan_el_attrcount += ret;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1343  			if (channels[i].type == IIO_TIMESTAMP)
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1344  				indio_dev->scan_index_timestamp =
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1345  					channels[i].scan_index;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1346  		}
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1347  		if (indio_dev->masklength && buffer->scan_mask == NULL) {
3862828a903d3c Andy Shevchenko    2019-03-04  1348  			buffer->scan_mask = bitmap_zalloc(indio_dev->masklength,
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1349  							  GFP_KERNEL);
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1350  			if (buffer->scan_mask == NULL) {
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1351  				ret = -ENOMEM;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1352  				goto error_cleanup_dynamic;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1353  			}
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1354  		}
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1355  	}
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1356  
418ff389a5a48a Alexandru Ardelean 2021-02-01  1357  	attrn = buffer_attrcount + scan_el_attrcount + ARRAY_SIZE(iio_buffer_attrs);
418ff389a5a48a Alexandru Ardelean 2021-02-01  1358  	attr = kcalloc(attrn + 1, sizeof(struct attribute *), GFP_KERNEL);
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1359  	if (!attr) {
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1360  		ret = -ENOMEM;
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1361  		goto error_free_scan_mask;
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1362  	}
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1363  
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1364  	memcpy(attr, iio_buffer_attrs, sizeof(iio_buffer_attrs));
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1365  	if (!buffer->access->set_length)
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1366  		attr[0] = &dev_attr_length_ro.attr;
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1367  
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1368  	if (buffer->access->flags & INDIO_BUFFER_FLAG_FIXED_WATERMARK)
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1369  		attr[2] = &dev_attr_watermark_ro.attr;
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1370  
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1371  	if (buffer->attrs)
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1372  		memcpy(&attr[ARRAY_SIZE(iio_buffer_attrs)], buffer->attrs,
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1373  		       sizeof(struct attribute *) * buffer_attrcount);
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1374  
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1375  	buffer_attrcount += ARRAY_SIZE(iio_buffer_attrs);
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1376  
418ff389a5a48a Alexandru Ardelean 2021-02-01  1377  	attrn = buffer_attrcount;
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1378  
418ff389a5a48a Alexandru Ardelean 2021-02-01  1379  	list_for_each_entry(p, &buffer->scan_el_dev_attr_list, l)
418ff389a5a48a Alexandru Ardelean 2021-02-01  1380  		attr[attrn++] = &p->dev_attr.attr;
418ff389a5a48a Alexandru Ardelean 2021-02-01  1381  
418ff389a5a48a Alexandru Ardelean 2021-02-01  1382  	buffer->buffer_group.name = kasprintf(GFP_KERNEL, "buffer%d", index);
418ff389a5a48a Alexandru Ardelean 2021-02-01  1383  	if (!buffer->buffer_group.name)
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1384  		goto error_free_buffer_attrs;

This needs to be "ret = -ENOMEM;"

e5d01923ab9239 Alexandru Ardelean 2021-02-01  1385  
418ff389a5a48a Alexandru Ardelean 2021-02-01  1386  	buffer->buffer_group.attrs = attr;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1387  
418ff389a5a48a Alexandru Ardelean 2021-02-01  1388  	ret = iio_device_register_sysfs_group(indio_dev, &buffer->buffer_group);
418ff389a5a48a Alexandru Ardelean 2021-02-01  1389  	if (ret)
418ff389a5a48a Alexandru Ardelean 2021-02-01  1390  		goto error_free_buffer_attr_group_name;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1391  
418ff389a5a48a Alexandru Ardelean 2021-02-01  1392  	/* we only need to link the legacy buffer groups for the first buffer */
418ff389a5a48a Alexandru Ardelean 2021-02-01  1393  	if (index > 0)
418ff389a5a48a Alexandru Ardelean 2021-02-01  1394  		return 0;
2dca9525701e36 Alexandru Ardelean 2021-02-01  1395  
418ff389a5a48a Alexandru Ardelean 2021-02-01  1396  	ret = iio_buffer_register_legacy_sysfs_groups(indio_dev, attr,
418ff389a5a48a Alexandru Ardelean 2021-02-01  1397  						      buffer_attrcount,
418ff389a5a48a Alexandru Ardelean 2021-02-01  1398  						      scan_el_attrcount);
2dca9525701e36 Alexandru Ardelean 2021-02-01  1399  	if (ret)
418ff389a5a48a Alexandru Ardelean 2021-02-01  1400  		goto error_free_buffer_attr_group_name;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1401  
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1402  	return 0;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1403  
418ff389a5a48a Alexandru Ardelean 2021-02-01  1404  error_free_buffer_attr_group_name:
418ff389a5a48a Alexandru Ardelean 2021-02-01  1405  	kfree(buffer->buffer_group.name);
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1406  error_free_buffer_attrs:
e5d01923ab9239 Alexandru Ardelean 2021-02-01  1407  	kfree(buffer->buffer_group.attrs);
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1408  error_free_scan_mask:
3862828a903d3c Andy Shevchenko    2019-03-04  1409  	bitmap_free(buffer->scan_mask);
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1410  error_cleanup_dynamic:
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1411  	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1412  
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26 @1413  	return ret;
d967cb6bd4e79c Lars-Peter Clausen 2014-11-26  1414  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--KtWcatouGV9Nk9BU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--KtWcatouGV9Nk9BU--
